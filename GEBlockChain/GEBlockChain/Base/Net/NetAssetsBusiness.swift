//
//  NetAssetsBusiness.swift
//  GEBlockChain
//
//  Created by nan li on 2020/7/28.
//  Copyright © 2020 darchain. All rights reserved.
//

enum NetAssetsBusiness {
    case preSubscriptList   //首页优选
    case getAssetsList
    case assetSubscribeList(Int, Int)  //认购市场认购列表
}

extension NetAssetsBusiness: NetTargetType {
    var method: Method {
        switch self {
        case .preSubscriptList:
            return.get
        case .getAssetsList:
            return .get
        case .assetSubscribeList:
            return .get
        }
    }
    
    public var path: String {
        switch self {
        case .preSubscriptList:
            return "home/subscribe/list"
        case .getAssetsList:
//            return "project/list?pageNum=1&pageSize=20"
            return "project/list"
        case .assetSubscribeList:
            return "asset/subscribe/list"
        
        }
    }
    
    public var task: Task {
        
        var params: [String: Any] = [:]
        switch self {
        case .preSubscriptList:
            params["pageNum"] = 1
            break
        case .getAssetsList:
            params["pageNum"] = 1
            params["pageSize"] = 20
            break
        case .assetSubscribeList(let page, let size):
            params["pageNumber"] = page
            params["pageSize"] = size
            break
//            return .requestPlain
        }
        
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
}

