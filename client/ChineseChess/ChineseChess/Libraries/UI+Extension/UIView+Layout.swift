//
//  UIView+Layout.swift
//  ChineseChess
//
//  Created by Cheryl on 2022/6/1.
//

import UIKit
import SnapKit

extension UIView {
	
	// MARK: - Layout. if this view belongs to ViewController, you should to use self.layout.
	open var layout: ConstraintAttributesDSL {
		if #available(iOS 11.0, *) {
			return self.safeAreaLayoutGuide.snp
		} else {
			return self.snp
		}
	}
	
}
