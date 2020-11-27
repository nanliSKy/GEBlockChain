//
//  NetCommissionBusiness.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/25.
//  Copyright © 2020 darchain. All rights reserved.
//

import Foundation

enum NetCommissionBussiness {
    //类型：0：收益，1：单价，2：数量
    //0：升序，1：降序
    case commissionList(Int, Int, Int, Int)  //交易市场委托订单

}


extension NetCommissionBussiness: NetTargetType {
    
    
    var path: String {
        switch self {
        case .commissionList:
            return "asset/commission/list"

        }
    }
    
    var method: Method {
        switch self {
        case .commissionList:
            return .get
       
        }
    }
    
    var task: Task {
        var params: [String: Any] = [:]
        switch self {
        case .commissionList(let orderBy, let sort, let page, let size):
            params["orderBy"] = orderBy
            params["sort"] = sort
            params["pageNumber"] = page
            params["pageSize"] = size
            break
        }
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    
}
