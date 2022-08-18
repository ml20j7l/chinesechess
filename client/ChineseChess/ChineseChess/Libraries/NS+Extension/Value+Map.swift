//
//  Value+Map.swift
//  ChineseChess
//
//  Created by Cheryl on 2022/6/1.
//

import UIKit

// MARK: - Map. target <- Option(value)
infix operator <-

public protocol Mappable {
	static func <-(_ left: inout Self, _ right: Any?)
}

extension Mappable {
	
	public static func <-(_ left: inout Self, _ right: Any?) {
		guard let value = right as? Self else { return }
		left = value
	}

}

// MARK: - Structs conform Mappable
extension Bool: Mappable {

}

extension Int: Mappable {
	
}

extension UInt64: Mappable {
	
}

extension String: Mappable {

}

extension Dictionary: Mappable {
	
}
