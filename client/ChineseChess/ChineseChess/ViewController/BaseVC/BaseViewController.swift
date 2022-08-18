//
//  BaseViewController.swift
//  ChineseChess
//
//  Created by Cheryl on 2022/6/1.
//

import UIKit

class BaseViewController: UIViewController {
        
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.initAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
        self.initAppearance()
    }
    
    private func initAppearance() {
        self.modalPresentationStyle = .fullScreen
    }
    
    // MARK: - Status Bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .none
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
