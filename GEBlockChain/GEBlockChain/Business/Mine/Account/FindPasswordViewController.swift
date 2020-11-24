//
//  FindPasswordViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/17.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class FindPasswordViewController: GEBaseViewController {

    @IBOutlet weak var codeClicek: UIButton!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var tfCert: UITextField!
    @IBOutlet weak var tfCode: UITextField!
    
    @IBOutlet weak var findPasswordButton: UIButton!
    private let mineViewModel = MineViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        findPasswordButton.vshadowColor(radius: 4, opacity: 0.5, s: CGSize(width: 0, height: 0), c: Pen.view(.basement))
        
        mineViewModel.inputFindPassword(account: tfPhone, code: tfCode, password: tfPassword, cert: tfCert)
        
        mineViewModel.sendCodeAction.values.observeValues { [unowned self] _ in
            Toast.show(message: "验证码已发送")
            self.codeClicek.timerCountDuration(duration: 60)
        }
        
        codeClicek.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] (sender) in
            self.sendCodeAction(sender)
        }
        
        mineViewModel.findPasswordAction.values.observeValues { (_) in
            Toast.show(message: "请重新登录")
            self.navigationController?.popViewController(animated: true)
        }
        findPasswordButton.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] (sender) in
            self.findPasswordAction(sender)
        }
        
        
        // Do any additional setup after loading the view.
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
    private func findPasswordAction(_ sender: UIButton) {
        
        self.view.endEditing(true)
        if (self.mineViewModel.enableFindPassword().value) {
            self.mineViewModel.findPasswordAction.apply().start()
        }else {
            Toast.show(message: self.mineViewModel.err.value)
        }
        Toast.show(mineViewModel.findPasswordAction.errors)
    }
    


    @IBAction func passwordClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        tfPassword.isSecureTextEntry = sender.isSelected
    }
    @IBAction func certClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        tfCert.isSecureTextEntry = sender.isSelected
    }
}


extension FindPasswordViewController {
    
    static func board() -> FindPasswordViewController {
       return Board(.Login).destination(FindPasswordViewController.self) as! FindPasswordViewController
    }
}
