//
//  ViewController.swift
//  MyChineseChess
//
//  Created by Cheryl on 2022/6/1.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let myPlayButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initView()
    }

    func initView(){
        let myImageView = UIImageView(image: UIImage(named: "bgImage"))
        self.view.addSubview(myImageView)
        
        myImageView.snp.makeConstraints { make in
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.top.equalTo(self.view.snp.top)
            make.bottom.equalTo(self.view.snp.bottom)
        }
        
        
//        let myStartButton = UIButton()
//        myStartButton.setTitle("单机游戏", for: UIControl.State.normal)
//        myStartButton.layer.borderWidth = 2
//        myStartButton.layer.borderColor = UIColor.orange.cgColor
//        myStartButton.addTarget(self, action: #selector(btnStartHandler), for: UIControl.Event.touchUpInside)
//        self.view.addSubview(myStartButton)
//        myStartButton.snp.makeConstraints { make in
//            make.centerX.equalTo(self.view.snp.centerX)
//            make.centerY.equalTo(self.view.snp.centerY).offset(-100)
//            make.width.equalTo(100)
//            make.height.equalTo(30)
//        }
        
        let game = UIButton()
        game.setTitle("Single Battle", for: UIControl.State.normal)
        game.titleLabel!.font = UIFont.boldSystemFont(ofSize: 25)
        game.layer.borderWidth = 5
        game.layer.borderColor = UIColor.orange.cgColor
        game.addTarget(self, action: #selector(btnFightHandler), for: UIControl.Event.touchUpInside)
        self.view.addSubview(game)
        game.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.snp.centerX)
            make.centerY.equalTo(self.view.snp.centerY).offset(-100)
            make.width.equalTo(150)
            make.height.equalTo(50)
        
        }
        self.view.addSubview(game)
        
        let lianji = UIButton() // button("对 弈", 1)
        lianji.setTitle("Fight Online", for: UIControl.State.normal)
        lianji.titleLabel!.font = UIFont.boldSystemFont(ofSize: 25)
        lianji.layer.borderWidth = 5
        lianji.layer.borderColor = UIColor.orange.cgColor
        lianji.addTarget(self, action: #selector(fonline), for: UIControl.Event.touchUpInside)
        self.view.addSubview(lianji)
        lianji.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.snp.centerX)
            make.centerY.equalTo(self.view.snp.centerY)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        self.view.addSubview(lianji)
        
        let myLabel = UILabel()
        myLabel.text = "CHINES CHESS"
        myLabel.font = UIFont.boldSystemFont(ofSize: 28)
        myLabel.textColor = UIColor.red
        self.view.addSubview(myLabel)
        myLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.snp.centerX).offset(60)
            make.centerY.equalTo(self.view.snp.centerY).offset(-200)
            make.width.equalTo(300)
            make.height.equalTo(80)
        }
        
        
        
        var playTitle:String = "Music(off)"
        if MyMusicPlayer.sharedInstance.getPlayStatus() {
            playTitle = "Music(on)"
            MyMusicPlayer.sharedInstance.playMusic()
        } else {
            MyMusicPlayer.sharedInstance.stopMusic()
        }
        
        myPlayButton.setTitle(playTitle, for: UIControl.State.normal)
        myPlayButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: 25)
        myPlayButton.layer.borderWidth = 5
        myPlayButton.layer.borderColor = UIColor.orange.cgColor
        myPlayButton.addTarget(self, action: #selector(btnPlayHandler), for: UIControl.Event.touchUpInside)
        myPlayButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.view.addSubview(myPlayButton)
        myPlayButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.snp.centerX)
            make.centerY.equalTo(self.view.snp.centerY).offset(100)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        
    }
    
    @objc func btnPlayHandler() {
        var playTitle:String = "Music(on)"
        if MyMusicPlayer.sharedInstance.getPlayStatus() {
            playTitle = "Music(off)"
            MyMusicPlayer.sharedInstance.stopMusic()
            
        } else {
            MyMusicPlayer.sharedInstance.playMusic()
        }
        
        myPlayButton.setTitle(playTitle, for: UIControl.State.normal)
    }
    
    @objc func btnStartHandler() {
        let vc = MyGameViewController()
        vc.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        self.present(vc, animated: true, completion: nil)
//        self.present("ChessViewController")
    }
    
    @objc func btnFightHandler() {
        let vc = GameVC()
        vc.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @objc func fonline() {
//        UIApplication.shared.openURL(NSURL.init(string: "http://localhost:8882/login")! as URL)
        self.present("FightViewController")
    }
    
}

