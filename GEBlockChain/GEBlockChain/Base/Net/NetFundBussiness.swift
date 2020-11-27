//
//  NetFundBussiness.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/24.
//  Copyright © 2020 darchain. All rights reserved.
//

import Foundation

enum NetFundBussiness {
    
    case profit  //收益
    case balance  //账户余额
    case ownerAssets(Int, Int)  //我的资产
    case ownerFlowAssets(Int, Int) //资金明细
    
//    //账号 密码或验证码 登录方式
//    case smsCode(account: String)
//    case login(account: String, code: String, password: String)
//    case regist(account: String, code: String, password: String, invateCode: String)
//    case findPassword(account: String, code: String, password: String)
//    var salt: String {
//       return "4308aec3-5d67-4a30-9065-ac125ad2bb8d"
//    }
}


extension NetFundBussiness: NetTargetType {
    
    
    var path: String {
        switch self {
        case .profit:
            return "fund/profit"
        case .balance:
            return "fund/balance"
        case .ownerAssets:
            return "asset/myAssets"
        case .ownerFlowAssets:
            return "fund/flow"
        
        }
    }
    
    var method: Method {
        switch self {
        case .profit:
            return .get
        case .balance:
            return .get
        case .ownerAssets:
            return .get
        case .ownerFlowAssets:
            return .get
        }
    }
    
    var task: Task {
        var params: [String: Any] = [:]
        switch self {
        case .profit:
            return .requestPlain
        case .balance:
            return .requestPlain
        case .ownerAssets(let page, let size):
            params["pageNumber"] = page
            params["pageSize"] = size
            break
        case .ownerFlowAssets(let page, let size):
            params["pageNumber"] = page
            params["pageSize"] = size
            break
        
//        case .smsCode(let phone):
//            params["phone"] = phone
//            break
//        case .regist(let phone, let code, let password, let invateCode):
//            params["phone"] = phone
//            params["code"] = code
//            params["password"] = "\(password)\(salt)".md5()
//            params["invateCode"] = invateCode
//            break
//        case .findPassword(let phone, let code, let password):
//            params["phone"] = phone
//            params["code"] = code
//            params["password"] = "\(password)\(salt)".md5()
//            break
//
        }
        
        //MARK: 将参数放在 httpBody中
//        return .requestData(jsonToData(jsonDic: params))
        
        
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
        
    }
    
}
