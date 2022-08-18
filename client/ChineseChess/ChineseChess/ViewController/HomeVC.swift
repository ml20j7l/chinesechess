//
//  HomeVC.swift
//  ChineseChess
//
//  Created by Cheryl on 2022/6/1.
//
//

import UIKit
import SnapKit

class HomeVC: BaseViewController {

	private lazy var scrollVC: ScrollVC = ScrollVC()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = UIColor.black
		self.initScrollView()
		self.initEntrances()
    }
	
	// Scrollview
	private func initScrollView() {
		self.scrollVC.setSuperview(superView: self.view)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
	}
	
	// Entrances
	private func initEntrances() {
		let layout = LayoutPartner.HomeVC()
		
		func button(_ title: String, _ tag: Int) -> UIButton {
			let button = UIButton.gold
			button.layer.cornerRadius = layout.buttonCordins
			button.titleLabel?.font = UIFont.kaitiFont(ofSize: layout.buttonTitleFontSize)
			button.addTarget(self, action: #selector(self.presentVC(sender:)), for: .touchUpInside)
			button.setTitle(title, for: .normal)
			button.tag = tag
			return button
		}
		
		let history = button("棋 谱", 2)
		self.view.addSubview(history)
		history.snp.makeConstraints {
			$0.size.equalTo(layout.buttonSize)
			$0.centerX.equalTo(self.view.layout.centerX)
			$0.top.equalTo(self.view.layout.centerY)
		}
		
		let game = button("对 弈", 1)
		self.view.addSubview(game)
		game.snp.makeConstraints {
			$0.size.equalTo(layout.buttonSize)
			$0.centerX.equalTo(self.view.layout.centerX)
			$0.bottom.equalTo(history.snp.top).offset(-layout.buttonSpace)
		}
		
		let multiPeer = button("联 机", 3)
		self.view.addSubview(multiPeer)
		multiPeer.snp.makeConstraints {
			$0.size.equalTo(layout.buttonSize)
			$0.centerX.equalTo(self.view.layout.centerX)
			$0.top.equalTo(history.snp.bottom).offset(layout.buttonSpace)
		}
		
		let titleView = UIImageView(image: ResourcesProvider.shared.image(named: "title"))
		self.view.addSubview(titleView)
		titleView.snp.makeConstraints {
			$0.size.equalTo(layout.titleViewSize)
			$0.centerX.equalTo(self.view.layout.centerX)
			$0.bottom.equalTo(game.snp.top).offset(-layout.titleViewSpace)
		}
	}
	
	deinit {
		NotificationCenter.default.removeObserver(self)
	}
    
}

// MARK: - Action
extension HomeVC {
	
	@objc func presentVC(sender: Any?) {
		guard let tag = (sender as? UIButton)?.tag else { return }
		WavHandler.playButtonWav()
		switch tag {
		case 1:
			self.present("GameVC")
		case 2:
			self.present("HistoryVC")
		case 3:
			self.present("MultiPeerVC")
		default:
			fatalError("Unknown sender trigger this function: \(#function), check the button's tag")
		}
	}
	
}

// MARK: - ScrollView Scroll Control
extension HomeVC {
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.scrollVC.isViewWillAppear = true
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		self.scrollVC.isViewDidAppear = true
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		self.scrollVC.isViewWillAppear = false
		self.scrollVC.isViewDidAppear = false
	}
	
	@objc func applicationWillEnterForeground() {
		self.scrollVC.isForeground = true
	}
	
	@objc func applicationDidEnterBackground() {
		self.scrollVC.isForeground = false
	}
	
}

// MARK: - ScrollViewController
extension HomeVC {
	
	private class ScrollVC: NSObject {
		
		// Public vars
		public var isForeground: Bool = true {
			didSet {
				if !oldValue {
					self.scrollViewShouldBeginScroll()
					self.imageViewShouldBeginRipple()
				}
			}
		}
		
		public var isViewWillAppear: Bool = false {
			didSet {
				if !oldValue {
					self.scrollViewShouldBeginScroll()
				}
			}
		}
		
		public var isViewDidAppear: Bool = false {
			didSet {
				if !oldValue {
					self.imageViewShouldBeginRipple()
				}
			}
		}

		public func setSuperview(superView: UIView) {
			superView.addSubview(self.scrollView)
			self.scrollView.snp.makeConstraints {
				$0.edges.equalTo(superView)
			}
			
			guard let image = ResourcesProvider.shared.image(named: "home") else { return }
			
			let imageView = UIImageView(image: image)
			self.imageView = imageView
			self.scrollView.addSubview(imageView)
			imageView.snp.makeConstraints {
				$0.edges.equalTo(self.scrollView)
				$0.height.equalTo(superView.snp.height)
				$0.width.equalTo(superView.snp.height).multipliedBy(image.size.width / image.size.height)
			}
		}
		
		// Private vars
		private lazy var scrollView: UIScrollView = {
			let scrollView = UIScrollView()
			scrollView.backgroundColor = UIColor.black
			scrollView.showsVerticalScrollIndicator = false
			scrollView.showsHorizontalScrollIndicator = false
			scrollView.bounces = false
			scrollView.isScrollEnabled = false
			scrollView.isUserInteractionEnabled = false
			return scrollView
		}()
		
		private var imageView: UIImageView?
		
		private var direction: CGFloat = 1.0
		private var currentOffset: CGFloat = 0.0
		
		@objc func scrollViewShouldBeginScroll() {
			guard self.isViewWillAppear && self.isForeground else { return }
			
			let targetOffset = self.currentOffset + self.direction
			if targetOffset > self.scrollView.contentSize.width - self.scrollView.bounds.size.width {
				self.direction = -1.0
			} else if(targetOffset + self.direction < 0.0) {
				self.direction = 1.0
			}
			
			self.currentOffset += self.direction
			self.scrollView.setContentOffset(CGPoint(x: self.currentOffset, y: 0), animated: true)
			self.perform(#selector(scrollViewShouldBeginScroll), with: nil, afterDelay: Macro.Time.homeScrollInterval)
		}
		
		private func imageViewShouldBeginRipple() {
			guard self.isViewDidAppear && self.isForeground else { return }
			
			self.imageView?.layer.removeAllAnimations()
			
			let animation = CATransition()
			animation.duration = Macro.Time.homeRippleInterval
            animation.type = CATransitionType(rawValue: "rippleEffect")
            animation.subtype = CATransitionSubtype.fromRight
			animation.repeatCount = Float.infinity
			
			self.imageView?.layer.add(animation, forKey: "animation")
		}
	}

}
