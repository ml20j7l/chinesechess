//
//  NSObject+Class.swift
//  ChineseChess
//
//  Created by Cheryl on 2022/6/1.
//

import UIKit

extension NSObject {
	
	public class func instance(from string: String) -> Any? {
		return (NSClassFromString("\(Macro.Project.name).\(string)") as? NSObject.Type)?.init()
	}
	
}
