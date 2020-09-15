//
//  NetAssetsBusiness.swift
//  GEBlockChain
//
//  Created by nan li on 2020/7/28.
//  Copyright © 2020 darchain. All rights reserved.
//

enum NetAssetsBusiness {
    case getAssetsList
}

extension NetAssetsBusiness: NetTargetType {
    var method: Method {
        switch self {
        case .getAssetsList:
            return .get
        }
    }
    
    public var path: String {
        switch self {
        case .getAssetsList:
//            return "project/list?pageNum=1&pageSize=20"
            return "project/list"
        
        }
    }
    
    public var task: Task {
        switch self {
        case .getAssetsList:
            var params:[String: Any] = [:]
            params["pageNum"] = 1
            params["pageSize"] = 20
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
}

