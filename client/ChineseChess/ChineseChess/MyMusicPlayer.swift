//
//  MyMusicPlayer.swift
//  MyChineseChess
//
//  Created by Cheryl on 2022/6/1.
//

import UIKit
import AVFoundation

class MyMusicPlayer: NSObject {

    static let sharedInstance = MyMusicPlayer()
    
     var player:AVAudioPlayer?
    
    private override init() {
        
        let url = Bundle.main.url(forResource: "bgMusic", withExtension: "mp3")
        player = try? AVAudioPlayer.init(contentsOf: url!)
        player?.numberOfLoops = -1
        player?.prepareToPlay()
    }
    
    func getPlayStatus() -> Bool {
        let myUserDefaults = UserDefaults.standard;
        
        let isPlay = myUserDefaults.bool(forKey: "isMusicOn")
        if isPlay {
            return true
        } else {
           
            return false
        }
        
    }
    
    func playMusic() {
       
        if player != nil {
            player?.play()
        }
        
        let myUserDefaults = UserDefaults.standard;
        myUserDefaults.setValue(true, forKey: "isMusicOn")
        
    }
    
    func stopMusic() {
        if player != nil && ((player?.isPlaying) != nil)  {
            player?.stop()
        }
        
        let myUserDefaults = UserDefaults.standard;
        myUserDefaults.setValue(false, forKey: "isMusicOn")
        
    }
}
