//
//  NResult.swift
//  GEBlockChain
//
//  Created by nan li on 2020/7/28.
//  Copyright © 2020 darchain. All rights reserved.
//

import Foundation

import Moya

extension Dictionary where Value == String, Key == String {
    public func multipartData() -> [MFData] {
        return self.map {
            MultipartFormData(provider: .data($1.data(using: .utf8)!), name: $0)
        }
    }
}

public struct DontCare: Codable {}

public struct NetResult<Care: Decodable> : Decodable {
    
    public var result: Care?
    
    public let message: String?
    
    public let code: Int?
    
    public let good: Bool
    
    private enum CodingKeys: String, CodingKey {
        case result = "data", code, message, good = "success"
    }
    
    /// 是否成功，后台信息
    public var info: BasicInfo {
        return BasicInfo(success: good, message: CodeInfo.default.message(by: code) ?? message, code: code)
    }
    
    /// 可能的错误信息
    public var errorInfo: NetError {
        return .business(info)
    }
    
    /// 此方法库外可见，不允许设置为网络错误
    ///
    /// - Parameters:
    ///   - result: 结果
    ///   - message: 信息
    ///   - code: 请求吗
    ///   - good: 是否成功
    public init(result: Care?, message: String?, code: Int?, good: Bool) {
        self.result = result
        self.message = message
        self.code = code
        self.good = good
    }
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let successValue = try container.decodeIfPresent(Bool.self, forKey: .good)

        message = try container.decodeIfPresent(String.self, forKey: .message)
        
        code = try container.decodeIfPresent(Int.self, forKey: .code)
        
        if let value = successValue {
            good = value
        } else {
            good = code == 0
        }
        
        if Care.self == DontCare.self {
            result = DontCare() as? Care
        }
        else {
            result = try container.decodeIfPresent(Care.self, forKey: .result)
        }
    }
}

    
extension NetResult {
    public static var ParseWrong: NetResult {
        return NetResult(result: nil, message: "数据异常，请联系客服", code: -999, good: false)
    }
}

public struct BasicInfo: CustomStringConvertible {
    /// 是否成功
       public let success: Bool
       
       /// 信息
       public let message: String?
       
       /// 状态码
       public let code: Int?
       
       public var description: String {
           
           switch code {
           case 1111, 1211: return "账号或密码错误，请重新输入"
           case 1311: return "验证码错误请重新获取"
           default: break
           }

           return message ?? ""
       }
       
       public init(success: Bool, message: String?, code: Int?) {
           self.success = success
           self.message = message
           self.code = code
       }
}

public enum NetError: Error, CustomStringConvertible {
    case business(BasicInfo), network(String, Response?)
    /// 解析错误
    public static var ParseWrong: NetError {
        return .business(BasicInfo(success: false, message: "数据异常，请联系客服", code: -999))
    }
    
    /// 快速创建业务错误
       ///
       /// - Parameters:
       ///   - business: 错误信息
       ///   - success: 是否成功 默认为 false
       ///   - code: 错误码 默认为 -1740
       /// - Returns: 业务错误
    public static func at<B: CustomStringConvertible>(business: B?, _ success: Bool = false, _ code: Int = -1740) -> NetError {
        return .business(BasicInfo(success: success, message: business?.description, code: code))
    }
    
    /// 原始的信息
    private var message: String? {
        switch self {
        case .business(let info):
            return info.description
        case .network(let info, _):
            return info
        }
    }
    
    /// 错误信息
    public var description: String {
        return message ?? ""
    }
}
