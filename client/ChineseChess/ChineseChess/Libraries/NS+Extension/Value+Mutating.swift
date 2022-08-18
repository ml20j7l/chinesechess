//
//  Value+Offset.swift
//  ChineseChess
//
//  Created by Cheryl on 2022/6/1.
//

import UIKit

extension CGSize {
		
	public mutating func offset(width: CGFloat, height: CGFloat) {
		self.width += width
		self.height += height
	}
	
	public mutating func contained(in size: CGSize) {
		if self.width > size.width {
			self.width = size.width
		}
		
		if self.height > size.height {
			self.height = size.height
		}
	}
	
}

extension Bool {
	
	public mutating func reverse() -> Bool {
		self = !self
		return self
	}
	
}

