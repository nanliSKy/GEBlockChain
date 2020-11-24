//
//  NetOrderBussiness.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/24.
//  Copyright © 2020 darchain. All rights reserved.
//

enum NetOrderBussiness {
    case orderBuy(String, String)
    case orderDetail(String)
}


extension NetOrderBussiness : NetTargetType {
    
    var method: Method {
        switch self {
        case .orderBuy:
            return.post
        case .orderDetail:
            return .post
        }
        
    }
    
    public var path: String {
        switch self {
        case .orderBuy:
            return "order/buy"
        
        case .orderDetail:
            return "order/buy/detail"
        }
    }
    
    public var task: Task {
        
        var params: [String: Any] = [:]
        switch self {
        case .orderBuy(let assetId, let quantity):
            params["assetId"] = assetId
            params["quantity"] = quantity
            break
        case .orderDetail(let orderId):
            params["orderId"] = orderId
            break
       
        }
        
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    
}



