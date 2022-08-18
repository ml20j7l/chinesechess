//
//  MyChessItem.swift
//  MyChineseChess
//
//  Created by Cheryl on 2022/6/1.
//

import UIKit

class MyChessItem: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
   
    var title = ""
    var isOwn = true
    var myIsSelect = false

    override init(frame:CGRect) {
       
        super.init(frame: CGRect(x: frame.origin.x + 2, y: frame.origin.y + 2 , width: frame.size.width - 4, height: frame.size.width - 4))
        self.layer.borderWidth = 0.5
       
        self.backgroundColor = UIColor.white
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: frame.size.width / 2)
        self.layer.cornerRadius = ( frame.size.width - 4 )/2
    }
    
    func setTitle(_ title:String){
        self.setTitle(title, for: UIControl.State.normal)
    }
    
    func setIsOwn(_ isOwn2:Bool) {
        self.isOwn = isOwn2
        if(self.isOwn){
            self.setTitleColor(UIColor.red, for: UIControl.State.normal)
            self.layer.borderColor = UIColor.red.cgColor
        } else {
            self.setTitleColor(UIColor.green, for: UIControl.State.normal)
            self.layer.borderColor = UIColor.green.cgColor
            self.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }
    }
    
    func setMyIsSelect(_ isSelect2:Bool) {
        if(isSelect2){
            self.myIsSelect = true
            self.backgroundColor = UIColor.purple
        } else {
            self.myIsSelect = false
            self.backgroundColor = UIColor.white
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
