//
//  MyChessTip.swift
//  MyChineseChess
//
//  Created by Cheryl on 2022/6/1.
//

import UIKit

class MyChessTip: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        let newX = frame.origin.x + frame.size.width / 2 - 10
        let newY = frame.origin.y + frame.size.height / 2 - 10
        super.init(frame: CGRect(x: newX, y: newY, width: 20, height: 20))
        
        self.backgroundColor = UIColor.purple
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
