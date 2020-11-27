//
//  NetAssetsBusiness.swift
//  GEBlockChain
//
//  Created by nan li on 2020/7/28.
//  Copyright © 2020 darchain. All rights reserved.
//

enum NetAssetsBusiness {
    case preSubscriptList   //首页优选
    case assetBaseDetail(String)
    case getStations(String)
    case assetSubscribeList(Int, Int)  //认购市场认购列表
    case getContract(String)
    case getAssetsNews(String, Int, Int) //信息披露
}

extension NetAssetsBusiness: NetTargetType {
    var method: Method {
        switch self {
        case .preSubscriptList:
            return.get
        case .assetBaseDetail:
            return .get
        case .getStations:
            return .get
        case .assetSubscribeList:
            return .get
        case .getContract:
            return .get
        case .getAssetsNews:
            return .get
        }
    }
    
    public var path: String {
        switch self {
        case .preSubscriptList:
            return "home/subscribe/list"
        case .assetBaseDetail:
            return "asset/base/detail"
        case .getStations:
//            return "project/list?pageNum=1&pageSize=20"
            return "asset/detail"
        case .assetSubscribeList:
            return "asset/subscribe/list"
        case .getContract:
            return "asset/file/list"
        case .getAssetsNews:
            return "asset/news/list"
        
        }
    }
    
    public var task: Task {
        
        var params: [String: Any] = [:]
        switch self {
        case .preSubscriptList:
            params["pageNum"] = 1
            break
        case .assetBaseDetail(let assetsId):
            params["assetId"] = assetsId
            break
        case .getStations(let stations):
            params["id"] = stations
            break
        case .assetSubscribeList(let page, let size):
            params["pageNumber"] = page
            params["pageSize"] = size
            break
        case .getContract(let stations):
            params["id"] = stations
            break
        case .getAssetsNews(let stations, let page, let size):
            params["pageNumber"] = page
            params["pageSize"] = size
            params["id"] = stations
            break
//            return .requestPlain
        }
        
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
}

