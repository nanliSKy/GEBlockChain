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
    case login(account: String, code: String, password: String)
    case regist(account: String, code: String, password: String, invateCode: String)
    case findPassword(account: String, code: String, password: String)
    var salt: String {
       return "4308aec3-5d67-4a30-9065-ac125ad2bb8d"
    }
}

extension NetLoginRegistBussiness: NetTargetType {
    
    
    var path: String {
        switch self {
        case .login:
            return "login"
        case .smsCode:
            return "messageCode"
        case .regist:
            return "register"
        case .findPassword:
            return "forgot"
        }
    }
    
    var method: Method {
        switch self {
        case .login:
            return .post
        case .smsCode:
            return .get
        case .regist:
            return .post
        case .findPassword:
            return .post
        }
    }
    
    var task: Task {
        var params: [String: Any] = [:]
        switch self {
        case .login(let phone, let code, let password):
            params["phone"] = phone
            params["code"] = code
            if password.count > 0 {
                params["password"] = "\(password)\(salt)".md5()
            }
            break
        case .smsCode(let phone):
            params["phone"] = phone
            break
        case .regist(let phone, let code, let password, let invateCode):
            params["phone"] = phone
            params["code"] = code
            params["password"] = "\(password)\(salt)".md5()
            params["invateCode"] = invateCode
            break
        case .findPassword(let phone, let code, let password):
            params["phone"] = phone
            params["code"] = code
            params["password"] = "\(password)\(salt)".md5()
            break
            
        }
        
        //MARK: 将参数放在 httpBody中
//        return .requestData(jsonToData(jsonDic: params))
        
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    
    
   
 
    
}
