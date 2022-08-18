//
//  UIFont+KaiTi.swift
//  ChineseChess
//
//  Created by cheryl on 2022/6/17.
//

import UIKit

extension UIFont {
	
	public class func kaitiFont(ofSize size: CGFloat) -> UIFont? {
		return UIFont(name: Macro.UI.fontName, size: size)
	}
	
}
