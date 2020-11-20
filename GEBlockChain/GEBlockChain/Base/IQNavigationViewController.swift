//
//  IQNavigationViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/17.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class IQNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        setupNavBarAppearence()
        // Do any additional setup after loading the view.
    }
    

    func setupNavBarAppearence() {
        // 设置导航栏默认的背景颜色
        WRNavigationBar.defaultNavBarBarTintColor =
            UIColor.init(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        // 设置导航栏所有按钮的
        WRNavigationBar.defaultNavBarTintColor = UIColor(red: 242/255.0, green: 77/255.0, blue: 51/255.0, alpha: 1)
        WRNavigationBar.defaultNavBarTitleColor = UIColor.black
        // 统一设置导航栏样式
//        WRNavigationBar.defaultStatusBarStyle = .lightContent
        // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
        WRNavigationBar.defaultShadowImageHidden = true
        
    }

    @objc func popCallBack() {
        self.popViewController(animated: true)
    }
}

extension IQNavigationViewController {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}

extension IQNavigationViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let rootVC: UIViewController = navigationController.viewControllers.first ?? UIViewController()
        if rootVC != viewController {
            
            var itemLeft: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_back"), style: .plain, target: self, action: #selector(popCallBack))
            if viewController.responds(to: #selector(popCallBack)) {
                itemLeft = UIBarButtonItem(image: UIImage(named: "nav_back"), style: .plain, target: viewController, action: #selector(popCallBack))
            }
            viewController.navigationItem.leftBarButtonItem = itemLeft
        }
    }
}
