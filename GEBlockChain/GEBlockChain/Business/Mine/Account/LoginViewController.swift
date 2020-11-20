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
        
    private let mineViewModel = MineViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        Localization.default.checkCurrentLanguage()
        view.backgroundColor = UIColor.white
        hbd_barTintColor = UIColor.white
        loginButton.vshadowColor(radius: 4, opacity: 0.5, s: CGSize(width: 0, height: 0), c: Pen.view(.basement))
        
        
        mineViewModel.input(account: tfphone, passwordOrCode: tfcode)
        
        mineViewModel.loginAction.values.observeValues {print("sssss")}
        loginButton.reactive.isEnabled <~ mineViewModel.loginAction.isExecuting.map{!$0}
        loginButton.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] (sender) in
            self.loginAction(sender)
        }
        
        
        mineViewModel.sendCodeAction.values.observeValues { [unowned self] _ in
            Toast.show(message: "验证码已发送")
            self.code.timerCountDuration(duration: 60)
        }
    
        regist.reactive.controlEvents(.touchUpInside).observeValues { (sender) in
            print("regist call")

        }

        code.reactive.controlEvents(.touchUpInside).observeValues { [self] (sender) in
            self.sendCodeAction(sender)
        }

        passwordControl.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] (sender) in

            if sender.isSelected && self.typeChange.isSelected {
                self.tfcode.isSecureTextEntry = true
            }else {
                self.tfcode.isSecureTextEntry = false
            }
            sender.isSelected = !sender.isSelected

        }

        passwordForget.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] (sender) in
            self.navigationController?.pushViewController(FindPasswordViewController.board(), animated: true)
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
                self.mineViewModel.type = "2"
            }else {
                self.loginType.text = "手机号登录"
                self.warnType.text = "验证码"
                self.tfcode.placeholder = "请输入手机验证码"
                self.passwordView.isHidden = true
                self.code.isHidden = false
                self.tfcode.isSecureTextEntry = false
                self.mineViewModel.type = "1"
            }
        }

    }
    
    
    private func sendCodeAction(_ sender: UIButton) {
        
        self.view.endEditing(true)
        if (self.mineViewModel.enableCode().value) {
            self.mineViewModel.sendCodeAction.apply().start()
        }else {
            Toast.show(message: self.mineViewModel.err.value)
        }
        Toast.show(mineViewModel.sendCodeAction.errors)
    }
    
    
    private func loginAction(_ sender: UIButton) {
        
        self.view.endEditing(true)
        if (self.mineViewModel.enableCCCCode().value) {
            self.mineViewModel.loginAction.apply().start()
        }else {
            Toast.show(message: self.mineViewModel.err.value)
        }
        Toast.show(mineViewModel.loginAction.errors)
    }
    
    @IBAction func tfPhoneClearClick(_ sender: Any) {
        tfphone.text = ""
    }
    
    @IBAction func loginClick(_ sender: UIButton) {
        
        
        self.view.endEditing(true)
        
        loginButton.reactive.isEnabled <~ mineViewModel.loginAction.isExecuting.map{!$0}
        mineViewModel.loginAction.values.observeValues {print($0)}
        
        loginButton.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] (sender) in
            if (self.mineViewModel.err.value.count > 0) {
                self.mineViewModel.loginAction.apply().start()
            }else {
                Toast.show(message: self.mineViewModel.err.value)
            }
            
        }
        loginButton.reactive.pressed = CocoaAction(mineViewModel.loginAction)
        Toast.show(mineViewModel.loginAction.errors)
     
        
//        viewModel.phone <~ tfphone.reactive.textValues
//        tfphone.reactive.continuousTextValues.observeValues { (text) in
//            print(text)
//        }
//        //两种传值方法
//        //1.input 参数
//
//        sender.reactive.pressed = CocoaAction(viewModel.loginAction, input: (tfphone.text ?? "", tfcode.text ?? "", "1"))
//
//        //2. 闭包传值
////        sender.reactive.pressed = CocoaAction(viewModel.smsAction) { [weak self] _ in
////            return self?.tfphone.text ?? ""
////        }
//
//        Toast.show(viewModel.loginAction.errors)
//
//
//        viewModel.loginAction.events.observeResult { (event) in
//            if case let Result.success(value) = event {
//                print("success: \(value)")
//            }
//            if case let Result.failure(error) = event {
//                print("error: \(error)")
//            }
//        }
        
     
    }
    
    @IBAction func pageCloseClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    deinit {
        code.cancel(backgroundColor: .blue)
    }
}


extension LoginViewController {
    static func void() -> LoginViewController {
       return Board(.Login).destination(LoginViewController.self) as! LoginViewController
    }
    
    class func showLoginVC(_ from: UIViewController?) {
        let vc: LoginViewController = Board(.Login).destination(LoginViewController.self) as! LoginViewController
        let nav: NavigationController = NavigationController(rootViewController: vc)
        from?.present(nav, animated: true, completion: nil)
    }
}
