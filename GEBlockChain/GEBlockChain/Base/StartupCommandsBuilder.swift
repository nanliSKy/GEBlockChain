//
//  StartupCommandsBuilder.swift
//  GEBlockChain
//
//  Created by nanli on 2020/7/22.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

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
    func execute() {
        ///根控制器
        let root = GETabBarViewController.init()
        keyWindow.rootViewController = root
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
    
    func setKeyWindow(_ window: UIWindow) -> StartupCommandsBuilder {
        self.window = window
        return self
    }
    
    @discardableResult
    func build() -> [Command] {
        return [
            InitializeThirdPartiesCommand(),
            InitialViewControllerCommand(keyWindow: window),
            InitializeAppearanceCommand(),
            InitalizeKeyBoardManagerCommand(),
            RegisterToRemoteNotificationsCommand(),
        ]
    }
    
}






