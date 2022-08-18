//
//  AppDelegate.swift
//  ChineseChess
//
//  Created by Cheryl on 2022/6/1.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	lazy var window: UIWindow? = {
		let window = UIWindow(frame: UIScreen.main.bounds)
		window.backgroundColor = UIColor.black
		window.rootViewController = ViewController()
		return window
	}()

	// MARK: - App Entrance
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// BGM 
//		WavHandler.playBGM(isLaunch: true)
		
		// Always Light
		UIApplication.shared.isIdleTimerDisabled = true
		
		self.window?.makeKeyAndVisible()
		Thread.sleep(forTimeInterval: Macro.Time.launchLastTime)
		return true
	}

	// MARK: - SaveData
	func applicationWillTerminate(_ application: UIApplication) {
		UserPreference.shared.savePreference()
	}

}

