//
//  Value+Meta.swift
//  ChineseChess
//
//  Created by Cheryl on 2022/6/1.
//

import UIKit

extension DispatchTime: ExpressibleByIntegerLiteral {
	
	public init(integerLiteral value: Int) {
		self = .now() + .seconds(value)
	}
	
}

extension Int {
	
	public var dispatchTime: DispatchTime {
		return DispatchTime(integerLiteral: self)
	}
	
}

extension TimeInterval {
	
	public var intValue: Int {
		return Int(self)
	}
	
}


