//
//  UIButton+Golden.swift
//  ChineseChess
//
//  Created by cheryl on 2022/6/17.
//

import UIKit

extension UIButton {
	
	public static var gold: UIButton {
		let button = UIButton(type: .custom)
		button.setBackgroundImage(ResourcesProvider.shared.image(named: "button"), for: .normal)
		button.layer.masksToBounds = true
		button.isExclusiveTouch = true
		button.setTitleColor(UIColor.china, for: .normal)
		button.setTitleColor(UIColor.red, for: .highlighted)
		button.setTitleColor(UIColor.lightGray, for: .disabled)
		return button
	}
	
}
