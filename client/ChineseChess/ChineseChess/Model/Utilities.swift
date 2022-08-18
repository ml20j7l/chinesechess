//
//  Utilities.swift
//  ChineseChess
//
//  Created by Cheryl on 2022/6/1.
//

import Foundation

struct Vector2: Equatable {
    var x: Int
    var y: Int
}

// all objects that conform to this protocol will now have default equality based on the protocol properties
func ==(lhs: Vector2, rhs: Vector2) -> Bool {
    return lhs.x == rhs.x && rhs.y == lhs.y
}

enum GameMode {
    case Human
    case AI
}

enum Player {
    case Black
    case Red
}

enum PieceStatus {
    case Alive
    case Died
}

