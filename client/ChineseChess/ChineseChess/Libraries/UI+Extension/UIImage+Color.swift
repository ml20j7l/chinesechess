//
//  UIImage+Color.swift
//  ChineseChess
//
//  Created by Cheryl on 2022/6/1.
//

import UIKit

extension UIImage {
	
	public func image(blende color: UIColor, overlay: Bool = false) -> UIImage? {
		UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
		defer {
			UIGraphicsEndImageContext()
		}
		
		color.setFill()
		UIRectFill(CGRect(origin: .zero, size: self.size))
		
		if overlay {
			self.draw(at: .zero, blendMode: .overlay, alpha: 1.0)
		}
		self.draw(at: .zero, blendMode: .destinationIn, alpha: 1.0)
		
		return UIGraphicsGetImageFromCurrentImageContext()
	}
	
}
