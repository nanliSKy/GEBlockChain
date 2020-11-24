//
//  RegistViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/8/19.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

class RegistViewController: GEBaseViewController {

    @IBOutlet weak var loginAction: UILabel!
    
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var tfCode: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var regist: UIButton!
    @IBOutlet weak var readClick: UIButton!
    @IBOutlet weak var readContext: UILabel!
    @IBOutlet weak var sendCode: UIButton!
    @IBOutlet weak var tfInvateCode: UITextField!
    
    private let mineViewModel = MineViewModel()
    override func viewDidLoad() {
        
        super.viewDidLoad()

        let attr = NSMutableAttributedString(string: "已有账号，马上登录")
        attr.addAttributes([.underlineStyle: NSUnderlineStyle.single.rawValue], range: NSRange(location: 0, length: attr.length))
        loginAction.attributedText = attr
        
        regist.vshadowColor(radius: 4, opacity: 0.5, s: CGSize(width: 0, height: 0), c: Pen.view(.basement))
        
        mineViewModel.inputRegist(account: tfPhone, code: tfCode, password: tfPassword, invateCode: tfInvateCode)
        
        

//        regist.reactive.pressed = CocoaAction(viewModel.registAction) {  _ in
//            return (self.tfPhone.text ?? "", self.tfCode.text ?? "", self.tfPassword.text ?? "")
//        }
//
//        Toast.show(viewModel.registAction.errors)
//
//
//        viewModel.registAction.events.observeResult { (event) in
//            if case let Result.success(value) = event {
//                print("success: \(value)")
//            }
//            if case let Result.failure(error) = event {
//                print("error: \(error)")
//            }
//        }
//
        mineViewModel.sendCodeAction.values.observeValues { [unowned self] _ in
            Toast.show(message: "验证码已发送")
            self.sendCode.timerCountDuration(duration: 60)
        }
        
        sendCode.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] (sender) in
            self.sendCodeAction(sender)
        }
        
        mineViewModel.regiserAction.values.observeValues { (_) in
            Toast.show(message: "注册成功")
            self.navigationController?.popViewController(animated: true)
        }
        regist.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] (sender) in
            self.registerAction(sender)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendCodeClick(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
    
    }
    @IBAction func readProtocolAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        mineViewModel.validReadProtocol.value = sender.isSelected
        
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
    private func registerAction(_ sender: UIButton) {
        
        self.view.endEditing(true)
        if (self.mineViewModel.enableRegist().value) {
            self.mineViewModel.regiserAction.apply().start()
        }else {
            Toast.show(message: self.mineViewModel.err.value)
        }
        Toast.show(mineViewModel.regiserAction.errors)
    }
    
    
    func registClick() {
        
//        regist.reactive.pressed = CocoaAction(viewModel.registAction, input: (tfPhone.text ?? "", tfCode.text ?? "", tfPassword.text ?? ""))
        
    }
}
