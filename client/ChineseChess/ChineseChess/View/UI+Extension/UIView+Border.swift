//
//  UIView+Border.swift
//  ChineseChess
//
//  Created by cheryl on 2022/6/17.
//

import UIKit

extension UIView {
	
	public func separtedBorder() {
		self.layer.cornerRadius = 5.0
		self.layer.borderWidth = 1.5
		self.layer.borderColor = UIColor.separtor.cgColor
		self.layer.masksToBounds = true
	}
	
}
