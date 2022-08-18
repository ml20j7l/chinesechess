import UIKit
import WebKit
class FightViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: "http://localhost:8882/login")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        let backr = UIButton() 
        backr.setTitle("back", for: UIControl.State.normal)
        backr.setTitleColor(.red, for: .normal)
//        backr.titleLabel?.textColor = UIColor.red
//        backr.layer.borderWidth = 2
//        backr.layer.borderColor = UIColor.black.cgColor
        backr.addTarget(self, action: #selector(back), for: UIControl.Event.touchUpInside)
        self.view.addSubview(backr)
        backr.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.snp.centerX).offset(100)
            make.centerY.equalTo(self.view.snp.centerY).offset(300)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        self.view.addSubview(backr)
    }
    @objc private func back() {
        self.dismiss()
    }
    
}
