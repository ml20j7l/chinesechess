//
//  Array+Split.swift
//  ChineseChess
//
//  Created by Cheryl on 2022/6/1.
//

import UIKit

extension Array {
	
	subscript (range: CountableClosedRange<Int>) -> [Element]? {
		guard range.lowerBound >= 0 && range.upperBound < self.endIndex && self.count > 0 else { return nil }
		
		var split: [Element] = []
		for index in range.sorted() {
			split.append(self[index])
		}
		return split
	}
	
}
