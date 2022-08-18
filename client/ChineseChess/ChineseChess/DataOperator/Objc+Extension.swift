//
//  Objc+Extension.swift
//  ChineseChess
//
//  Created by Cheryl on 2022/6/1.
//

// MARK: - LunaBoardState
extension LunaBoardState {
	
	public var description: String {
		switch self {
		case .turnRedSide:
			return " RED TURN"
		case .turnBlackSide:
			return " BLACK TURN "
			
		case .draw50RoundHaveNoneEat:
			return " Draw, 50 rounds without taking a piece "
		case .drawSamePositionMultiTimes:
			return " 和棋, 相同的局面出现多次 "
		case .drawBothSideHaveNoneAttckChess:
			return " Draw, the same position appears multiple times "
			
		case .winNormalRed:
			return " RED WIN "
		case .winNormalBlack:
			return " BLACK WIN "
		case .winLongCatchRed:
			return " RED WIN, LongCatchRed"
		case .winLongCatchBlack:
			return " BLACK WIN, LongCatchBlack "
        
        @unknown default:
            return "unkown"
        }
	}
	
	public var isNormalState: Bool {
		return self.rawValue <= LunaBoardState.turnBlackSide.rawValue
	}
	
	public var result: String {
		switch self {
		case .turnRedSide, .turnBlackSide:
			return "result: unkown"
			
		case .draw50RoundHaveNoneEat, .drawSamePositionMultiTimes, .drawBothSideHaveNoneAttckChess:
			return "result: draw"
			
		case .winNormalRed, .winLongCatchRed:
			return "result: RED WIN "
		case .winNormalBlack, .winLongCatchBlack:
			return "result: BLACK WIN "
            
        @unknown default:
            return "result: unkown"
        }
	}
	
	public var vs: String {
		switch self {
		case .turnRedSide, .turnBlackSide:
			return "-"
			
		case .draw50RoundHaveNoneEat, .drawSamePositionMultiTimes, .drawBothSideHaveNoneAttckChess:
			return "draw"
			
		case .winNormalRed, .winLongCatchRed:
			return "win"
		case .winNormalBlack, .winLongCatchBlack:
			return "lose"
        
        @unknown default:
            return "-"
        }
	}
	
}

// MARK: - Bool, Side
extension Bool {
	
	public var isRed: Bool {
		return !self
	}
	
}

// MARK: - LunaMove
extension LunaMove {
	
	public var from: LunaLocation {
		return LunaLocation(self >> 8)
	}
	
	public var to: LunaLocation {
		return LunaLocation(self & 0xff)
	}
	
}

// MARK: - LunaChess
extension LunaChess {
	
	public var name: String {
		switch self {
		case 16:
			return "帥"
		case 32:
			return "將"
			
		case 17, 18:
			return "仕"
		case 33, 34:
			return "士"
			
		case 19, 20:
			return "相"
		case 35, 36:
			return "象"
			
		case 21, 22, 37, 38:
			return "馬"
			
		case 23, 24, 39, 40:
			return "車"
			
		case 25, 26:
			return "炮"
		case 41, 42:
			return "砲"
			
		case 27, 28, 29, 30, 31:
			return "兵"
		case 43, 44, 45, 46, 47:
			return "卒"
		
		default:
			return ""
		}
	}
	
}

// MARK: - LunaRecord
extension LunaRecord {
	
	var item: CharacterView.DataItem {
		return CharacterView.DataItem(Int(self.chess), self.character, Int(self.eat))
	}
	
}

// MARK: - LunaPutChessState
extension LunaPutChessState {
	
	public func description(name: String) -> String {
		switch self {
		case .wrongPut:
			return "\(name)can't move there"
		case .wrongEat:
			return "\(name)can't remove"
		default:
			return ""
		}
	}
	
}

// MARK: - LunaEditDoneState
extension LunaEditDoneState {
	
	public func description(state: LunaBoardState) -> String {
		
		switch self {
		case .wrongFaceToFace:
			return "kings will meet"
		case .wrongIsCheckedMate:
			return "\(state == .turnRedSide ? "RED" : "BLACK")none to play"
		case .wrongCheck:
			return "\(state == .turnRedSide ? "將" : "帥")will be eaten"
		default:
			return ""
		}
	}
	
}
