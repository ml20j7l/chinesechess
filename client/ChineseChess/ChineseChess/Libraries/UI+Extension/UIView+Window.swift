//
//  UIView+Window.swift
//  ChineseChess
//
//  Created by Cheryl on 2022/6/1.
//

import UIKit

extension UIWindow {
	
	public static var window: UIWindow? {
		return (UIApplication.shared.delegate as? AppDelegate)?.window
	}
	
}
