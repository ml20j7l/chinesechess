//
//  Horse.swift
//  ChineseChess
//
//  Created by cheryl on 2022/6/25.
//  
//

import Foundation

class Horse : Piece {
    override func nextPossibleMoves(boardStates: [[Piece?]]) -> [Vector2] {
        // // For horse, it requires a "日" shape with 3 steps
        let possibleMoves: [Vector2] = [
            Vector2(x: position.x - 1, y: position.y + 2),
            Vector2(x: position.x - 1, y: position.y - 2),
            Vector2(x: position.x - 2, y: position.y - 1),
            Vector2(x: position.x - 2, y: position.y + 1),
            Vector2(x: position.x + 1, y: position.y + 2),
            Vector2(x: position.x + 1, y: position.y - 2),
            Vector2(x: position.x + 2, y: position.y + 1),
            Vector2(x: position.x + 2, y: position.y - 1)
        ]
        
        var ret : [Vector2] = []
        
        for _move in possibleMoves {
            if isValidMove(_move, boardStates) {
                ret.append(_move)
            }
        }
        
        return ret
    }
    
    override func isValidMove(_ move: Vector2, _ boardStates: [[Piece?]]) -> Bool {
        if Board.isOutOfBoard(move) {
            return false
        }
        
        let nextState = boardStates[move.x][move.y]
        
        if nextState != nil {
            if nextState?.owner == self.owner {
                return false
            }
        }

        let boo = position.x < move.x ? (min: position.x, max: move.x) :
            (min: move.x, max: self.position.x)
            
        let foo = position.y < move.y ? (min: position.y, max: move.y) :
            (min: move.y, max: position.y)
            
        if (foo.max - foo.min == 2) && (boardStates[position.x][foo.min + 1] == nil) {
            return true
        }
            
        if (boo.max - boo.min == 2) && (boardStates[boo.min + 1][position.y] == nil) {
            return true
        }

        return false
    }
}


