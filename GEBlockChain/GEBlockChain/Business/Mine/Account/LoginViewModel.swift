//
//  LoginViewModel.swift
//  GEBlockChain
//
//  Created by nan li on 2020/8/19.
//  Copyright © 2020 darchain. All rights reserved.
//

import Foundation

import ReactiveSwift

class LoginViewModel: ViewModel {
    
    let net = Net<NetLoginRegistBussiness>()
    
    let phone = MutableProperty<String?>(nil)
    let code = MutableProperty<String?>(nil)
    
    //MARK: phone
    let smsAction: Action<String, Void, NetError>
    
    //MARK: login
    let loginAction:Action<(String, String, String), Account, NetError>
    
    //MARK: regist
    let registAction:Action<(String, String, String), Void, NetError>
    init() {
        
        smsAction = Action<String, Void, NetError>.init(execute: { [unowned net] (phone) -> SignalProducer<Void, NetError> in
            print(phone)
            return net.detach(.smsCode(account: phone))
        })
        
        loginAction = Action<(String, String, String), Account, NetError>.init(execute: { [unowned net] (phone, code, type) -> SignalProducer<Account, NetError> in
            return net.detach(.login(account: phone, code: code, type: type), Account.self)
        })
        
        registAction = Action<(String, String, String), Void, NetError>.init(execute: { [unowned net] (account, code, password) -> SignalProducer<Void, NetError> in
            return net.detach(.regist(account: account, code: code, password: password))
        })
    }
}

struct Account: Decodable{
    let token: String?
    let uid: String?
    let area: String?
    
    
    private enum CodingKeys: String, CodingKey {
        case token, uid, area
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        token = try container.decodeIfPresent(String.self, forKey: .token)
        uid = try container.decodeIfPresent(String.self, forKey: .uid)
        area = try container.decodeIfPresent(String.self, forKey: .area)
    }
}
