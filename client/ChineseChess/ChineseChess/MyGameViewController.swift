//
//  MyGameViewController.swift
//  MyChineseChess
//
//  Created by Cheryl on 2022/6/1.
//

import UIKit

class MyGameViewController: UIViewController {

    let itemWidth = ( UIScreen.main.bounds.width - 40 ) / 9.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backr = UIButton() 
        backr.setTitle("back", for: UIControl.State.normal)
        backr.setTitleColor(.red, for: .normal)
//        backr.titleLabel?.textColor = UIColor.red
        backr.layer.borderWidth = 2
        backr.layer.borderColor = UIColor.black.cgColor
        backr.addTarget(self, action: #selector(back), for: UIControl.Event.touchUpInside)
        self.view.addSubview(backr)
        backr.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.snp.centerX)
            make.centerY.equalTo(self.view.snp.centerY).offset(-300)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        self.view.addSubview(backr)
        
        self.view.backgroundColor = UIColor.white

//        let item = MyChessItem(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
//        item.setTitle( "车")
//        item.setIsOwn( true)
//        item.addTarget(self, action: #selector(itemClickHandler(sender:)), for: UIControl.Event.touchUpInside)
//        self.view.addSubview(item)
//
//        let item2 = MyChessItem(frame: CGRect(x: 50, y: 200, width: 100, height: 100))
//        item2.setTitle( "士")
//        item2.setIsOwn( false)
//        item2.addTarget(self, action: #selector(itemClickHandler(sender:)), for: UIControl.Event.touchUpInside)
//
//        self.view.addSubview(item2)
        
        let myChessBoard = MyChessBoard(frame: CGRect(x: UIScreen.main.bounds.width/2 - 4.5*itemWidth, y: UIScreen.main.bounds.height/2 - 5.5*itemWidth, width: 9.0*itemWidth, height: 10.0 * itemWidth))
        myChessBoard.backgroundColor = UIColor.white
        self.view.addSubview(myChessBoard)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc private func back() {
        self.dismiss()
    }
    
    @objc func itemClickHandler(sender:MyChessItem) {
        if(sender.myIsSelect) {
            sender.setMyIsSelect(false)
        } else {
            sender.setMyIsSelect(true)
        }
    }
}
