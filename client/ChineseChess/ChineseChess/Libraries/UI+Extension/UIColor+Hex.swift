//
//  UIColor+Hex.swift
//  ChineseChess
//
//  Created by Cheryl on 2022/6/1.
//

import UIKit

extension UIColor {
	
	public convenience init(hexColor vector: UInt32, alpha: CGFloat = 1.0) {
		let red: CGFloat = CGFloat((vector & 0xff0000) >> 16) / 255.0
		let green: CGFloat  = CGFloat((vector & 0xff00) >> 8) / 255.0
		let blue: CGFloat  = CGFloat(vector & 0xff) / 255.0
		
		self.init(red: red, green: green, blue: blue, alpha: alpha)
	}

}
