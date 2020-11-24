//
//  MineViewModel.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/18.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import ReactiveSwift

typealias NSignal<T> = ReactiveSwift.Signal<T, Never>
typealias Producer<T> = ReactiveSwift.SignalProducer<T, NetError>

class MineViewModel: ViewModel {
    
    
    let net = Net<NetLoginRegistBussiness>()
    
    private(set) var err = MutableProperty("请完善信息")
    private(set) var validAccount = MutableProperty("")
    private(set) var validPasswordOrCode = MutableProperty("")
 
    //注册
    private(set) var validPassword = MutableProperty("")
    private(set) var validInvateCode = MutableProperty("")
    private(set) var validReadProtocol = MutableProperty(false)
    
    //找回密码
    private(set) var validCertPassword = MutableProperty("")
    
    //登录类型 1｜验证码 ；2｜密码
    var type: String = "1"
    
    func input(account: UITextField, passwordOrCode: UITextField) {
//        validAccount <~ account.reactive.continuousTextValues.map({ [unowned self] (text) -> String in
//            if (text.count == 0) {
//                self.err.value = "请输入账户信息"
//            }else{
//                self.err.value = ""
//            }
//            return text
//        })
//
//        validPasswordOrCode <~ passwordOrCode.reactive.continuousTextValues.map({ (text) -> String in
//            if (text.count == 0) {
//                self.err.value = self.type == "1" ? "请输入验证码" : "请输入密码"
//            }else{
//                self.err.value = ""
//            }
//            return text
//        })
        
        validAccount <~ account.reactive.textValues
        validPasswordOrCode <~ passwordOrCode.reactive.textValues
    }
    
    func inputRegist(account: UITextField, code: UITextField, password: UITextField, invateCode: UITextField) {
        validAccount <~ account.reactive.textValues
        validPasswordOrCode <~ code.reactive.textValues
        validPassword <~ password.reactive.textValues
        validInvateCode <~ invateCode.reactive.textValues
    }
    
    func inputFindPassword(account: UITextField, code: UITextField, password: UITextField, cert: UITextField) {
        validAccount <~ account.reactive.textValues
        validPasswordOrCode <~ code.reactive.textValues
        validPassword <~ password.reactive.textValues
        validCertPassword <~ cert.reactive.textValues
    }
    
    
    private var enableCCCode: Property<Bool> {
        return Property.combineLatest(validAccount, validPasswordOrCode).map { [unowned self] (account, passwordOrCode) -> Bool in
            
            if (account.count > 0 && passwordOrCode.count > 0) {
                return true
            }
            Toast.show(message: self.err.value)
            return false
        }
    }
    
    func enableCCCCode() -> Property<Bool> {
        return Property.combineLatest(validAccount, validPasswordOrCode).map {(account, passwordOrCode) -> Bool in
            
            if (account.count > 0 && passwordOrCode.count > 0) {
                return true
            }
            if account.count <= 0 {
                self.err.value = "请输入账户信息"
            }else if (passwordOrCode.count <= 0) {
                self.err.value = self.type == "1" ? "请输入验证码" : "请输入密码"
            }
            
            return false
        }
    }
    
    func enableRegist() -> Property<Bool> {
        return Property.combineLatest(validAccount, validPasswordOrCode, validPassword, validInvateCode, validReadProtocol).map {(account, code, password, invateCode, read) -> Bool in
            if (account.count > 0 && code.count > 0 && password.count > 0 && read) {
                return true
            }
            if account.count <= 0 {
                self.err.value = "请输入账户信息"
            }else if (code.count <= 0) {
                self.err.value = "请输入验证码"
            }else if (password.count <= 0) {
                self.err.value = "请输入密码"
            }else if (read == false) {
                self.err.value = "请阅读并同意《用户协议》"
            }
            
            return false
        }
    }
    
    func enableFindPassword() -> Property<Bool> {
        return Property.combineLatest(validAccount, validPasswordOrCode, validPassword, validCertPassword).map {(account, code, password, certPassword) -> Bool in
            if (account.count > 0 && code.count > 0 && password.count > 0 && certPassword.count > 0) {
                return true
            }
            if account.count <= 0 {
                self.err.value = "请输入账户信息"
            }else if (code.count <= 0) {
                self.err.value = "请输入验证码"
            }else if (password.count <= 0) {
                self.err.value = "请输入密码"
            }else if (certPassword != password) {
                self.err.value = "请确认新密码"
            }
            
            return false
        }
    }
    
    func enableCode() -> Property<Bool> {
        return validAccount.map { [unowned self] (text) -> Bool in
            if (text.count > 0) {
                return true
            }
            self.err.value = "请输入账户信息"
            return false
        }
    }
       
    private(set) lazy var sendCodeAction = Action<(), Void, NetError> { [unowned self] (phone) -> Producer<Void> in
        return self.sendCode;
    }

    private var sendCode: Producer<Void> {
        return net.detach(.smsCode(account: validAccount.value))
    }
    
    
    ///登录
//    private(set) lazy var loginAction = Action<(), Void, NetError>(enabledIf: enableCCCCode()) { [unowned net, unowned self] _ -> SignalProducer<Void, NetError> in
//
//        return net.detach(.login(account: self.validAccount.value, code: self.type == "1" ? self.validPasswordOrCode.value : "", password: self.type == "1" ? "" : self.validPasswordOrCode.value))
//    }
    
    private(set) lazy var loginAction = Action<(), TToken, NetError> { [unowned net, unowned self] _ -> SignalProducer<TToken, NetError> in
        return net.detach(.login(account: self.validAccount.value, code: self.type == "1" ? self.validPasswordOrCode.value : "", password: self.type == "1" ? "" : self.validPasswordOrCode.value), TToken.self)
    }
    
    
    /// 注册
    private(set) lazy var regiserAction = Action<(), Void, NetError> { [unowned net, unowned self] (_) -> SignalProducer<Void, NetError> in
        net.detach(.regist(account: self.validAccount.value, code: self.validPasswordOrCode.value, password: self.validPassword.value, invateCode: ""))
    }
    
    //找回密码
    private(set) lazy var findPasswordAction = Action<(), Void, NetError> { [unowned net, unowned self] (_) -> SignalProducer<Void, NetError> in
        net.detach(.findPassword(account: self.validAccount.value, code: self.validPasswordOrCode.value, password: self.validPassword.value))
    }
}
