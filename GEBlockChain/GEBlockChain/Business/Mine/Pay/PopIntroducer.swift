//
//  PopIntroducer.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/20.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class ICPopCheckViewController: UIPresentationController {
    
    var displaySize: CGSize = CGSize(width: 0, height: 0)
    
    private var backView: UIView {
        let view = UIView()
        view.frame = self.containerView?.bounds ?? CGRect(x: 0, y: 0, width: Device.width, height: Device.height)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
    }
    
    func changeSize(size: CGSize) {
        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.curveEaseInOut) {
            self.presentedView?.frame = CGRect(x: 0, y: Device.height - size.height, width: self.displaySize.width, height: size.height)
        } completion: { (done) in
            
        }
    }
    
    override func presentationTransitionWillBegin() {
        self.containerView?.addSubview(self.backView)
        self.backView.alpha = 0
        UIView.animate(withDuration: 0.2) {
            self.backView.alpha = 1
        }
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = CGRect(x: 0, y: Device.height - self.displaySize.height, width: self.displaySize.width, height: self.displaySize.height)
    }
    
}

class PopIntroducer: NSObject {
    
    private var displaySize: CGSize = CGSize(width: 0, height: 0)
    private var vc: ICPopCheckViewController?

    static func introduce(_ size: CGSize) -> PopIntroducer {
        let pop = PopIntroducer()
        pop.displaySize = size
        return pop
    }
    
    static func introduce() -> PopIntroducer {
        let pop = PopIntroducer()
        return pop
    }
    
    func introducerSize(_ size: CGSize) {
        self.displaySize = size
    }
    
    func changeSize(_ size: CGSize) {
        self.vc?.changeSize(size: size)
    }
}

extension PopIntroducer: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let vc = ICPopCheckViewController(presentedViewController: presented, presenting: presenting)
        vc.displaySize = self.displaySize
        self.vc = vc
        return vc
    }
}
