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
    
    func enableCode() -> Property<Bool> {
        return validAccount.map { [unowned self] (text) -> Bool in
            if (text.count > 0) {
                return true
            }
            self.err.value = "请输入账户信息"
            return false
        }
    }
       
    ///发送获取验证码请求
//    private(set) lazy var sendCodeAction = Action<(), Void, NetError>(enabledIf: enableCCode) { [unowned self] (phone) -> Producer<Void> in
//        return self.sendCode;
//    }
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
    
    private(set) lazy var loginAction = Action<(), Void, NetError> { [unowned net, unowned self] _ -> SignalProducer<Void, NetError> in
        return net.detach(.login(account: self.validAccount.value, code: self.type == "1" ? self.validPasswordOrCode.value : "", password: self.type == "1" ? "" : self.validPasswordOrCode.value))
    }
    

}
