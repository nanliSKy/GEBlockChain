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
    
    let viewModel = LoginViewModel.init()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        let attr = NSMutableAttributedString(string: "已有账号，马上登录")
        attr.addAttributes([.underlineStyle: NSUnderlineStyle.single.rawValue], range: NSRange(location: 0, length: attr.length))
        loginAction.attributedText = attr
        
        
        
        
        //2. 闭包传值
        //        sender.reactive.pressed = CocoaAction(viewModel.smsAction) { [weak self] _ in
        //            return self?.tfphone.text ?? ""
        //        }
        
        
//        regist.reactive.controlEvents(.touchUpInside).observeValues { [weak self] (sender) in
//            self?.registClick()
//        }
//
        regist.reactive.pressed = CocoaAction(viewModel.registAction) {  _ in
            return (self.tfPhone.text ?? "", self.tfCode.text ?? "", self.tfPassword.text ?? "")
        }
        
        Toast.show(viewModel.registAction.errors)
        
        
        viewModel.registAction.events.observeResult { (event) in
            if case let Result.success(value) = event {
                print("success: \(value)")
            }
            if case let Result.failure(error) = event {
                print("error: \(error)")
            }
        }
        // Do any additional setup after loading the view.
    }
    

    func registClick() {
        
        regist.reactive.pressed = CocoaAction(viewModel.registAction, input: (tfPhone.text ?? "", tfCode.text ?? "", tfPassword.text ?? ""))
        
    }
}
