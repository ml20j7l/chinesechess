//
//  GameVC.swift
//  ChineseChess
//
//  Created by Cheryl on 2022/6/1.
//

import UIKit

class GameVC: ChessVC {

	private lazy var chessBoardController: GameBoardController = GameBoardController(contentView: self.contentView, board: self.board, AI: self.AI, isUserInteractionEnabled: true)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.layoutTopAndBottom(target: self, attributes: [
			("Setting", #selector(settings)),
			("Hint", #selector(teachMe)),
			("Back", #selector(back)),
			("New", #selector(newGame)),
			("Regret", #selector(regretOneStep)),
			("Menu", #selector(showMenu)),
			])
		
		self.chessBoardController.delegate = self
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.refreshUI()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		self.chessBoardController.tryThinking()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		self.chessBoardController.stopThinking()
	}
	
	private func refreshUI() {
		self.AI.initBoard(withFile: UserPreference.shared.game.record)
		self.chessBoardController.reverse = UserPreference.shared.game.reverse
		self.chessBoardController.opposite = UserPreference.shared.game.opposite
		self.refreshTopBottom()
	}
	
	public override func updateUserPreference() {
		UserPreference.shared.game.record = self.AI.historyFile()
		UserPreference.shared.savePreference()
	}
	
}

// MARK: - GameSettings.
extension GameVC: GameSettingsViewDelegate {
	
	@objc private func newGame() {
		GameSettingsView().show(isNew: true, delegate: self)
	}
	
	@objc private func settings() {
		GameSettingsView().show(isNew: false, delegate: self)
	}
	
	func gameSettingsViewDidClickOk(isNew: Bool, levels: [UserPreference.Level]) {
		self.chessBoardController.gameSettingsViewDidClickOk(isNew: isNew, levels: levels)
		self.refreshTopBottom()
	}
	
	private func refreshTopBottom() {
		if UserPreference.shared.game.reverse {
			self.setSideState(top: ChessVC.SideState.side(level: UserPreference.shared.game.red, isRed: true), bottom: ChessVC.SideState.side(level: UserPreference.shared.game.black, isRed: false))
			self.setNickname(top: UserPreference.shared.game.red.description, bottom: UserPreference.shared.game.black.description)
		} else {
			self.setSideState(top: ChessVC.SideState.side(level: UserPreference.shared.game.black, isRed: false), bottom: ChessVC.SideState.side(level: UserPreference.shared.game.red, isRed: true))
			self.setNickname(top: UserPreference.shared.game.black.description, bottom: UserPreference.shared.game.red.description)
		}
	}
	
}

// MARK: - Menu.
extension GameVC: MenuViewDelegate, CharacterViewDelegate, EditVCDelegate {
	
	@objc private func showMenu() {
		GameMenuView().show(delegate: self)
	}
	
	func menuView(_ menuView: NavigationView, didSelectRowAt index: Int) {
		switch index {
		case 0:
            self.chessBoardController.asyncTask { (release) in
                self.chessBoardController.reverse = UserPreference.shared.game.reverse
                self.refreshTopBottom()
                
                release()
            }
            
		case 1:
            self.chessBoardController.asyncTask { (release) in
                self.chessBoardController.opposite = UserPreference.shared.game.opposite
                
                release()
            }
            
		case 2:
			menuView.push(view: CharacterView(delegate: self, dataSource: self.AI.records.map({ return $0.item }), result: self.AI.state.result))
            
		case 3:
			menuView.dismiss()
			
			let vc = EditVC()
			vc.AI.initBoard(withFile: self.AI.historyFile())
			vc.delegate = self
            
			self.present(vc)
            
		default:
			break
		}
	}
	
	func characterView(didClickAt index: Int) {
		if index == 0 {
			UserPreference.shared.history.save(time: Date.time, name: self.name, description: self.detail, file: self.AI.historyFile())
			TextAlertView.show(in: self.contentView, text: "saved")
		} else {
			UIPasteboard.general.string = "\(self.detail)\n\(self.AI.characters)"
			TextAlertView.show(in: self.contentView, text: "copied")
		}
	}
	
	var detail: String {
        return "red：\(UserPreference.shared.game.red.description)\nblack：\(UserPreference.shared.game.black.description)\nturns：\((self.AI.count + 1) >> 1)\nstep：\(self.AI.count)\nstate：\(self.AI.state.description)"
	}
	
	private var name: String {
		return "\(UserPreference.shared.game.red.name) \(self.AI.state.vs) \(UserPreference.shared.game.black.name)"
	}
	
	func didDoneEdit(with file: String) {
		UserPreference.shared.game.record = file
	}
	
}

// MARK: - Other
extension GameVC: GameBoardControllerDelegate {
	
	@objc private func back() {
		WavHandler.playButtonWav()
		self.dismiss()
	}
	
	@objc private func regretOneStep() {
		self.chessBoardController.complexRegret()
	}
	
	@objc private func teachMe() {
		WavHandler.playButtonWav()
		self.chessBoardController.techMe()
	}
	
	var progress: Float {
		get {
			return 0.0
		}
        
		set {
			self.setFlashProgress(progress: newValue)
		}
	}
	
	func gameBoardControllerDidChangeSide() {
		self.refreshTopBottom()
	}
	
}
