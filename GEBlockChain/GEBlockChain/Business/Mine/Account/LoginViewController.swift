//
//  LoginViewController.swift
//  GEBlockChain
//
//  Created by nanli on 2020/7/22.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

import ReactiveCocoa

import ReactiveSwift

class LoginViewController: GEBaseViewController {
    
    @IBOutlet weak var tfphone: UITextField!
    
    @IBOutlet weak var tfcode: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var regist: UIButton!
    
    @IBOutlet weak var code: UIButton!
    
    @IBOutlet weak var passwordView: UIView!
    
    @IBOutlet weak var warnType: UILabel!
    
    @IBOutlet weak var loginType: UILabel!
    
    @IBOutlet weak var typeChange: UIButton!
    
    @IBOutlet weak var passwordForget: UIButton!
    
    @IBOutlet weak var passwordControl: UIButton!
    
    let viewModel = LoginViewModel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        hbd_barTintColor = UIColor.white
        
        tfphone.reactive.continuousTextValues.observeValues { (text) in
            print(text)
        }
        
        loginButton.vshadowColor(radius: 4, opacity: 0.5, s: CGSize(width: 0, height: 0), c: Pen.view(.basement))
        
        regist.reactive.controlEvents(.touchUpInside).observeValues { (sender) in
            print("regist call")
            
        }
        
        Localization.default.checkCurrentLanguage()
        code.reactive.controlEvents(.touchUpInside).observeValues { (sender) in
            sender.timerCountDuration(duration: 60, disableBackgroundColor: .white, disableTitleColor: .gray)
        }
        
        passwordControl.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] (sender) in
            sender.isSelected = !sender.isSelected
            if sender.isSelected && self.typeChange.isSelected {
                self.tfcode.isSecureTextEntry = true
            }else {
                self.tfcode.isSecureTextEntry = false
            }
            
            
        }
        
        
        
        typeChange.setTitle("验证码登录".localized, for: .selected)
        typeChange.setTitle("密码登录".localized, for: .normal)
        typeChange.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] (sender) in
            sender.isSelected = !sender.isSelected
            self.tfcode.text = nil
            self.passwordControl.isSelected = false
            if sender.isSelected {
                self.loginType.text = "密码登录"
                self.warnType.text = "密码"
                self.tfcode.placeholder = "请输入密码"
                self.passwordView.isHidden = false
                self.code.isHidden = true
                self.tfcode.isSecureTextEntry = true
            }else {
                self.loginType.text = "手机号登录"
                self.warnType.text = "验证码"
                self.tfcode.placeholder = "请输入手机验证码"
                self.passwordView.isHidden = true
                self.code.isHidden = false
                self.tfcode.isSecureTextEntry = false
            }
        }

    }
    
    @IBAction func loginClick(_ sender: UIButton) {
        
        viewModel.phone <~ tfphone.reactive.textValues
        
        //两种传值方法
        //1.input 参数
        
        sender.reactive.pressed = CocoaAction(viewModel.loginAction, input: (tfphone.text ?? "", tfcode.text ?? "", "1"))
        
        //2. 闭包传值
//        sender.reactive.pressed = CocoaAction(viewModel.smsAction) { [weak self] _ in
//            return self?.tfphone.text ?? ""
//        }
        
        Toast.show(viewModel.loginAction.errors)
    
        
        viewModel.loginAction.events.observeResult { (event) in
            if case let Result.success(value) = event {
                print("success: \(value)")
            }
            if case let Result.failure(error) = event {
                print("error: \(error)")
            }
        }
        
     
    }
    
    
    deinit {
        code.cancel(backgroundColor: .blue)
    }
}


extension LoginViewController {
    static func void() -> LoginViewController {
       return Board(.Login).destination(LoginViewController.self) as! LoginViewController
    }
}
