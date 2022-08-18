//
//  UIView+Tap.swift
//  ChineseChess
//
//  Created by Cheryl on 2022/6/1.
//

import UIKit

// MARK: - TapAction.
extension UIView {
	
	public func addTapTarget(_ target: Any?, action: Selector) {
		let tap = UITapGestureRecognizer(target: target, action: action)
		tap.numberOfTapsRequired = 1
		tap.numberOfTouchesRequired = 1
		self.addGestureRecognizer(tap)
		self.isUserInteractionEnabled = true
	}
	
}
