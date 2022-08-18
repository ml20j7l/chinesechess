//
//  ChessBrain.swift
//  ChineseChess
//
//  Created by cheryl on 2022/6/25.
//  
//

import Foundation

// UI independent model

class ChessBrain {
    public var pending : Piece?
    private var currentPlayer : Player = .Red // Red player is the first one to play
    public var gameStates = Board.initialBoardStates
    public var winner : Player?
    
    public func setPiece(piece: Piece) {
        
        if (winner != nil) { return }
        
        if let firstSelection = pending {
            /* If the second piece selection belongs to 
             * the same player with the first piece, set pending piece to the
             * second one.
             */
            if ( firstSelection.owner == piece.owner ) {
                pending = piece
                return
            }
            
            if checkMovementAvailability(destination: piece.position) {
                eatPiece(food: piece)
            }

        } else {
            if (piece.owner == currentPlayer) {
                pending = piece
            }
        }
    }
    
    public func checkMovementAvailability(destination: Vector2) -> Bool {
        if let piece = pending {
            let nextPossibleMoves = piece.nextPossibleMoves(boardStates: gameStates)
            
            if nextPossibleMoves.contains(where: {$0 == destination}) {
                // Update gamestates
                gameStates[piece.position.x][piece.position.y] = nil
                gameStates[destination.x][destination.y] = piece
                piece.setPosition(destination)
                
                // Next player's turn
                currentPlayer = turnPlayer(player: currentPlayer)
                
                pending = nil
                return true
            }
        }
        
        return false
    }
    
    private func eatPiece(food: Piece) {
        // Set the piece status to Died
        food.status = .Died
        
        if food is King {
            if (food.owner == .Black) {
                winner = .Red
            } else {
                winner = .Black
            }
        }
    }
    
    private func turnPlayer(player: Player) -> Player {
        
        if (player == .Red) {
            return .Black
        } else {
            return .Red
        }
    }
    
    // Reset everything
    func replay() {
        pending = nil
        currentPlayer = .Red
        gameStates = Board.initialBoardStates
        winner = nil
        
        for i in (0 ..< Board.rows) {
            for j in (0 ..< Board.columns) {
                if let piece = gameStates[i][j] {
                    piece.setPosition(Vector2(x: i, y: j))
                    
                    // reset all the piece to Alive status
                    piece.status = .Alive
                }
            }
        }
    }
}
