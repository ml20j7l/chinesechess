//
//  UITableView+Update.swift
//  ChineseChess
//
//  Created by Cheryl on 2022/6/1.
//

import UIKit

extension UITableView {
	
	public func insert(indexPaths: [IndexPath]) {
		guard indexPaths.count > 0 else { return }
		
		self.beginUpdates()
		self.insertRows(at: indexPaths, with: .automatic)
		self.endUpdates()
	}
	
	public func delete(indexPaths: [IndexPath]) {
		guard indexPaths.count > 0 else { return }
		
		self.beginUpdates()
		self.deleteRows(at: indexPaths, with: .automatic)
		self.endUpdates()
	}
	
}
