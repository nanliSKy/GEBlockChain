//
//  StartupCommandsBuilder.swift
//  GEBlockChain
//
//  Created by nanli on 2020/7/22.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import ESTabBarController_swift
import IQKeyboardManagerSwift

protocol Command {
    func execute()
}

struct InitializeThirdPartiesCommand: Command {
    
    func execute() {
        //第三方代码初始化
    }
}

struct InitialViewControllerCommand: Command {
    
    let keyWindow: UIWindow
    let app: AppDelegate
    
    func execute() {
        ///根控制器
//        let root = GETabBarViewController.init()
//        keyWindow.rootViewController = root
//        keyWindow.makeKeyAndVisible()
        
        let tabBarController = ESTabBarController()
        tabBarController.tabBar.shadowImage = UIImage(named: "tabbarBackground")
        let v1 = HomeViewController.board()
        let v2 = TradeContainerViewController()
        let v3 = GEMineViewController()
             
        
        v1.tabBarItem = ESTabBarItem.init(IQIrregularityItemContentView(), title: "首页", image: UIImage(named: "Tab_Bar_Index")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "Tab_Bar_Index_Selected")?.withRenderingMode(.alwaysOriginal))
        v2.tabBarItem = ESTabBarItem.init(IQIrregularityItemContentView() ,title: "交易", image: UIImage(named: "Tab_Bar_Trade")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "Tab_Bar_Trade_Selected")?.withRenderingMode(.alwaysOriginal))
        v3.tabBarItem = ESTabBarItem.init(IQIrregularityItemContentView() ,title: "我的", image: UIImage(named: "Tab_Bar_Mine")?.withRenderingMode(.alwaysOriginal),
                                          selectedImage: UIImage(named: "Tab_Bar_Mine_Selected")?.withRenderingMode(.alwaysOriginal))
               
        let n1 = NavigationController.init(rootViewController: v1)
        let n2 = NavigationController.init(rootViewController: v2)
        let n3 = NavigationController.init(rootViewController: v3)
     
        tabBarController.viewControllers = [n1, n2, n3]
        keyWindow.rootViewController = tabBarController
        keyWindow.makeKeyAndVisible()
    }
    
}

struct InitializeAppearanceCommand: Command {
    
    func execute() {
        ///全局外观样式设置
        Appearance.appearance()
    }
}

struct RegisterToRemoteNotificationsCommand: Command {
    func execute() {
        ///远程推送配置
    }
}

struct InitalizeKeyBoardManagerCommand: Command {
    func execute() {

        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
}

struct InitalizeKeyInternationalizationCommand: Command {
    func execute() {
        ///国际化
        
    }
}

final class StartupCommandsBuilder {
    
    private var window: UIWindow!
    private var app: AppDelegate!
    
    func setKeyWindow(_ window: UIWindow, app: AppDelegate) -> StartupCommandsBuilder {
        self.window = window
        self.app = app
        return self
    }
    
    @discardableResult
    func build() -> [Command] {
        return [
            InitializeThirdPartiesCommand(),
            InitialViewControllerCommand(keyWindow: window, app: app),
            InitializeAppearanceCommand(),
            InitalizeKeyBoardManagerCommand(),
            RegisterToRemoteNotificationsCommand(),
        ]
    }
    
}






