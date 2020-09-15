//
//  NetLoginRegistBussiness.swift
//  GEBlockChain
//
//  Created by nan li on 2020/8/19.
//  Copyright © 2020 darchain. All rights reserved.
//

enum NetLoginRegistBussiness {
    //账号 密码或验证码 登录方式
    case smsCode(account: String)
    case login(account: String, code: String, type: String)
    case regist(account: String, code: String, password: String)
    
    var salt: String {
       return "4308aec3-5d67-4a30-9065-ac125ad2bb8d"
    }
}

extension NetLoginRegistBussiness: NetTargetType {
    
    
    var path: String {
        switch self {
        case .login:
            return "foreign/login"
        case .smsCode:
            return "foreign/sendVfcode"
        case .regist:
            return "foreign/register"
        }
    }
    
    var method: Method {
        switch self {
        case .login:
            return .post
        case .smsCode:
            return .post
        case .regist:
            return .post
        }
    }
    
    var task: Task {
        var params: [String: Any] = [:]
        switch self {
        case .login(let phone, let code, let type):
            params["account"] = "86,\(phone)"
            params["vfcode"] = code
//            params["password"] = code
            params["type"] = type
            break
        case .smsCode(let phone):
            params["account"] = phone
            break
        case .regist(let phone, let code, let password):
            params["account"] = "86,\(phone)"
            params["vfcode"] = code
            params["password"] = "\(password)\(salt)".md5()
            break
        }
        
        //MARK: 将参数放在 httpBody中
        return .requestData(jsonToData(jsonDic: params))
        
//        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    
    
   
 
    
}
