//
//  Value+Random.swift
//  ChineseChess
//
//  Created by Cheryl on 2022/6/1.
//

import UIKit

// MARK: - Random
extension Double {
	public static var random: Double {
		return Double(arc4random()) / Double(UInt32.max)
	}
}

extension Float {
	public static var random: Float {
		return Float(Double.random)
	}
}

extension CGFloat {
	public static var random: CGFloat {
		return CGFloat(Double.random)
	}
}
