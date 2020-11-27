//
//  WebContrainerViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/25.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import WebKit

class WebContrainerViewController: GEBaseViewController {

    private let progress = UIProgressView()
    private let webView: WKWebView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
    
    private var contract: Contract?
    override func viewDidLoad() {
        super.viewDidLoad()

        title = contract?.name
        
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalTo(view)
        }
        progress.tintColor = Pen.view(.basement)
        progress.progress = 0.0
        view.addSubview(progress)
        progress.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(view.snp.top).offset(Device.navBarHeight + 5)
        }
        
        let request = URLRequest(url: URL(string: (contract?.url)!)!)
        webView.load(request)
        // Do any additional setup after loading the view.
    }
    

}

extension WebContrainerViewController: WKNavigationDelegate {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let path = keyPath{
            if path == "estimatedProgress" {
                if let wk = object as? WKWebView {
                    progress.isHidden = wk.estimatedProgress == 1.0
                    progress.setProgress(Float(webView.estimatedProgress), animated: true)
                }
            }
        }
    }
}

extension WebContrainerViewController {
    static func board(_ contract: Contract) -> WebContrainerViewController {
        let vc: WebContrainerViewController = WebContrainerViewController()
        vc.contract = contract
        return vc
    }
}
