//
//  GameBoardController.swift
//  ChineseChess
//
//  Created by Cheryl on 2022/6/1.
//

import UIKit

protocol GameBoardControllerDelegate: NSObjectProtocol {
	
	var progress: Float { set get }
	
	func gameBoardControllerDidChangeSide()
	
}

class GameBoardController: ChessBoardController {
	
	// the GridPoint current player selected.
	private var choice: (grid: GridPoint, layer: CALayer?) = (GridPoint.none, nil)
	
	// the GridPoints of the selected chess can go.
	private var legalMoves: [GridPoint: CALayer] = [:]
	
	// the lastest move.
	private var lastMove: (from: CALayer?, to: CALayer?) = (nil, nil)
	
	// isMoving reveals the chess is moving or not.
	private var isMoving: Bool = false
	
	// isRegreting reveals the game is in progress of regreting.
	private var isRegreting: Bool = false
	
	// taskQueue, to avoid data mess. Reverse, opposite and chess move should be serially executed.
	private let taskQueue: DispatchQueue = DispatchQueue(label: "com.sulioppa.game.taskQueue")
	private let taskSignal: DispatchSemaphore = DispatchSemaphore(value: 1)
	
	public weak var delegate: GameBoardControllerDelegate? = nil
	
	// MARK: - Handle Tap
	public override func didTapInBoard(at grid: ChessBoardController.GridPoint, atPoint: CGPoint) {
		let canRespond = self.canRespond
		if !canRespond.can {
			TextAlertView.show(in: self.contentView, text: canRespond.error)
			return
		}
		
		if self.choice.grid.isLegal {
			// has chosen one.
			if grid == self.choice.grid {
				WavHandler.playVoice(state: .select)
				return
			}
			
			// not the same grid, try to make another choice.
			if self.makeChoice(location: grid.location(self.reverse)) {
				return
			}
			
			// make the move
			if self.legalMoves[grid] != nil {
				self.makeMove(to: grid)
			}
		} else {
			// not chose. try to make a choice.
			let _ = self.makeChoice(location: grid.location(self.reverse))
		}
	}
	
	// MARK: - Board Operation
	public override func refreshBoard() {
		super.refreshBoard()
		self.refreshLastMove(with: self.AI.lastMove?.move)
	}
	
	public override func clearBoard() {
		super.clearBoard()
		self.clearLastMove()
		self.clearChoice()
		self.clearLegalMoves()
	}
	
}

// MARK: - Public
extension GameBoardController {
	
	func gameSettingsViewDidClickOk(isNew: Bool, levels: [UserPreference.Level]) {
		if isNew {
			self.newGame(with: levels)
		} else {
			self.didModifySettings(with: levels)
		}
	}
	
	public final func complexRegret() {
		if self.isRegreting || self.isMoving || self.AI.count == 0 {
			WavHandler.playButtonWav()
			return
		}
		
		self.isRegreting = true
		self.stopThinking()
		
		if self.AI.side.isRed {
			if UserPreference.shared.game.black.isPlayer {
				self.regretStep(onlyOne: true)
			} else if UserPreference.shared.game.red.isPlayer && self.AI.count > 1 {
				self.regretStep(onlyOne: false)
			} else {
				UserPreference.shared.game.black = .player
				self.delegate?.gameBoardControllerDidChangeSide()
				self.regretStep(onlyOne: true)
			}
		} else {
			if UserPreference.shared.game.red.isPlayer {
				self.regretStep(onlyOne: true)
			} else if UserPreference.shared.game.black.isPlayer && self.AI.count > 1 {
				self.regretStep(onlyOne: false)
			} else {
				UserPreference.shared.game.red = .player
				self.delegate?.gameBoardControllerDidChangeSide()
				self.regretStep(onlyOne: true)
			}
		}
	}
	
	public final func techMe() {
		guard !self.AI.isThinking && self.AI.state.isNormalState else { return }
		
		self.startThinking()
	}
	
	public final func tryThinking() {
		guard !self.AI.isThinking && self.AI.state.isNormalState else { return }
		
		if self.AI.side.isRed {
			if !UserPreference.shared.game.red.isPlayer {
				self.startThinking()
			}
		} else if !UserPreference.shared.game.black.isPlayer {
			self.startThinking()
		}
	}
	
	private func startThinking() {
		guard !self.AI.isThinking else { return }
        
		self.AI.isThinking = true
        let level = self.AI.side ? UserPreference.shared.game.black : UserPreference.shared.game.red
        
        self.AI.nextStep(withDepth: Int32(level.rawValue)) { (progress, move) in
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else { return }
                guard self.AI.isThinking else { return }
                
                self.delegate?.progress = progress
                
                guard move > 0 else { return }

                self.asyncTask(task: { (release) in
                    guard self.AI.isThinking else {
                        release()
                        return
                    }
                    
                    self.makeMove(move: move, completion: release)
                })
            }
		}
	}
	
	public final func stopThinking() {
		self.AI.isThinking = false
		self.delegate?.progress = 0.0
	}

}

// MARK: - Private - Support Handling Tap
extension GameBoardController {
	
	private var canRespond: (can: Bool, error: String?) {
		if self.isMoving {
			return (false, nil)
		} else if self.AI.isThinking {
			return (false, "AI正在思考...")
        } else if !self.AI.state.isNormalState {
            return (false, self.AI.state.description)
        }
		
		return (true, nil)
	}
	
	private func makeChoice(location: LunaLocation) -> Bool {
		if self.AI.isAnotherChoice(withLocation: location) {
			WavHandler.playVoice(state: .select)
			self.refreshChoice(with: location)
			self.refreshLegalMoves(with: location)
			return true
		}
		return false
	}
	
	private func makeMove(to: GridPoint) {
		self.clearLegalMoves()
		let move = GridPoint.move(from: self.choice.grid, to: to, isReverse: self.reverse)
		let state = self.AI.moveChess(withMove: move)
		WavHandler.playVoice(state: state)

		self.moveChess(from: self.choice.grid, to: to)
		self.refreshLastMove(with: self.AI.lastMove?.move)
		self.clearChoice()
		
		if !self.AI.state.isNormalState {
			BladeAlertView.show(in: self.contentView, text: self.AI.state.description)
		}
		
		NotificationCenter.default.post(name: Macro.NotificationName.didUpdateOneStep, object: nil, userInfo: [
			"item": self.AI.lastMove!.item,
			"result": self.AI.state.result
			])
	}
	
    private func makeMove(move: LunaMove, completion: @escaping () -> Void) {
		self.clearLegalMoves()
		let state = self.AI.moveChess(withMove: move)
		WavHandler.playVoice(state: state)
		
		let from = GridPoint(location: move.from, isReverse: self.reverse)
		let to = GridPoint(location: move.to, isReverse: self.reverse)
		
        self.moveChess(with: {
            self.isMoving = true
        }, from: from, to: to, completion: {
            self.isMoving = false
            completion()
            
            self.stopThinking()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + Macro.Time.AIThinkingInterval, execute: {
                self.tryThinking()
            })
        })
        
		self.refreshLastMove(with: self.AI.lastMove?.move)
		self.clearChoice()
		
		if !self.AI.state.isNormalState {
			BladeAlertView.show(in: self.contentView, text: self.AI.state.description)
		}
		
		NotificationCenter.default.post(name: Macro.NotificationName.didUpdateOneStep, object: nil, userInfo: [
			"item": self.AI.lastMove!.item,
			"result": self.AI.state.result
			])
	}
	
	// choice
	private func refreshChoice(with location: LunaLocation) {
		self.clearChoice()
		self.choice.grid.reset(location: location, isReverse: self.reverse)
		self.choice.layer = self.drawSquare(isRed: true, grid: self.choice.grid)
	}
	
	private func clearChoice() {
		self.choice.layer?.removeFromSuperlayer()
		self.choice.layer = nil
		self.choice.grid.clear()
	}
	
	// legal moves
	private func refreshLegalMoves(with choice: LunaLocation) {
		self.clearLegalMoves()
		// draw ruby
		for (_, location) in self.AI.legalMoves(withLocation: choice).enumerated() {
			let result = self.drawRuby(location: location.uint8Value)
			self.legalMoves[result.grid] = result.ruby
		}
	}
	
	private func clearLegalMoves() {
		for (_, item) in self.legalMoves.enumerated() {
			item.value.removeFromSuperlayer()
		}
		self.legalMoves.removeAll()
	}
	
	// last move
	private func refreshLastMove(with move: LunaMove?) {
		self.clearLastMove()
		if let move = move, move != 0 {
			self.lastMove.from = self.drawSquare(isRed: false, location: move.from)
			self.lastMove.to = self.drawSquare(isRed: false, location: move.to)
		}
	}
	
	private func clearLastMove() {
		self.lastMove.from?.removeFromSuperlayer()
		self.lastMove.to?.removeFromSuperlayer()
		self.lastMove.from = nil
		self.lastMove.to = nil
	}
	
}

// MARK: - Private - Chess move and recover
extension GameBoardController {
	
	private func moveChess(from: GridPoint, to: GridPoint) {
		self.asyncTask { [weak self] (release) in
			self?.moveChess(with: {
				self?.isMoving = true
			}, from: from, to: to, completion: {
				self?.isMoving = false
				release()
                
                self?.stopThinking()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + Macro.Time.AIThinkingInterval, execute: {
                    self?.tryThinking()
                })
			})
		}
	}
	
	private func recoverChess(from: GridPoint, to: GridPoint, recover: Int, completion: (() -> Void)?) {
		self.asyncTask { [weak self] (release) in
			self?.recoverChess(with: {
				self?.isMoving = true
			}, from: from, to: to, recover: recover, completion: {
				self?.isMoving = false
				completion?()
				release()
			})
		}
	}
	
	internal func asyncTask(task: @escaping (@escaping () -> Void) -> Void) {
		self.taskQueue.async { [weak self] in
			self?.taskSignal.wait()
			DispatchQueue.main.async {
				task() {
					self?.taskSignal.signal()
				}
			}
		}
	}
	
}

// MARK: - Private - Board Operation
extension GameBoardController {
	
	private func newGame(with levels: [UserPreference.Level]) {
		self.stopThinking()
		
		UserPreference.shared.game.red = levels[0]
		UserPreference.shared.game.black = levels[1]
		UserPreference.shared.game.prompt = levels[2]
		
		self.asyncTask { [weak self] (release) in
			self?.AI.initBoard(withFile: nil)
			self?.refreshBoard()
			
			release()
			self?.tryThinking()
		}
	}
	
	private func didModifySettings(with levels: [UserPreference.Level]) {
		UserPreference.shared.game.red = levels[0]
		UserPreference.shared.game.black = levels[1]
		UserPreference.shared.game.prompt = levels[2]
		
		if self.AI.state == .turnRedSide {
			if self.AI.isThinking && UserPreference.shared.game.red.isPlayer {
				self.stopThinking()
			} else if !self.AI.isThinking && !UserPreference.shared.game.red.isPlayer {
				self.tryThinking()
			}
		} else if self.AI.state == .turnBlackSide {
			if self.AI.isThinking && UserPreference.shared.game.black.isPlayer {
				self.stopThinking()
			} else if !self.AI.isThinking && !UserPreference.shared.game.black.isPlayer {
				self.tryThinking()
			}
		}
	}
	
	private func regretStep(onlyOne: Bool) {
		var move: LunaMove = 0
		let ate = Int(self.AI.regret(withMove: &move))
		
		guard move > 0 else { return }
		
		self.recoverChess(from: GridPoint(location: move.to, isReverse: self.reverse), to: GridPoint(location: move.from, isReverse: self.reverse), recover: ate) {
			if onlyOne {
				self.isRegreting = false
			} else {
				self.regretStep(onlyOne: true)
			}
		}
		
		self.clearChoice()
		self.clearLegalMoves()
		self.refreshLastMove(with: self.AI.lastMove?.move)
		WavHandler.playVoice(state: .normal)
	}
	
}
