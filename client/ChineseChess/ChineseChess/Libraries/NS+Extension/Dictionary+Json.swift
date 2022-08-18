//
//  Dictionary+Json.swift
//  ChineseChess
//
//  Created by Cheryl on 2022/6/1.
//

import UIKit

extension Dictionary {
	
	public var data: Data? {
		return try? JSONSerialization.data(withJSONObject: self, options: .default)
	}
	
	public static func dictionary(from data: Data?) -> [String: Any]? {
		guard let data = data else { return nil }
		
		let obj = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
		return obj as? [String: Any]
	}
	
}

// MARK: - JSONSerialization.WritingOptions
extension JSONSerialization.WritingOptions {
	
	public static let `default`: JSONSerialization.WritingOptions = {
		return JSONSerialization.WritingOptions(rawValue: 0)
	}()

}
