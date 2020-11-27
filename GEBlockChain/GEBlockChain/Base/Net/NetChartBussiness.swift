//
//  NetChartBussiness.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/25.
//  Copyright © 2020 darchain. All rights reserved.
//

import Foundation

enum NetChartBussiness {
    case sparklinesRate(String)  //走势图,年化回报率
    case sparklinesProfit(String, Int) //走势图,单份投资回报
    case sparklinesPower(String, Int) //走势图,发电走势
}

extension NetChartBussiness: NetTargetType {
    var path: String {
        switch self {
        case .sparklinesRate:
            return "asset/sparklines/rate"
        case .sparklinesProfit:
            return "asset/sparklines/profit"
        case .sparklinesPower:
            return "asset/sparklines/power"

        }
    }
    
    var method: Method {
        switch self {
        case .sparklinesRate:
            return .get
        case .sparklinesProfit:
            return .get
        case .sparklinesPower:
            return .get
       
        }
    }
    
    var task: Task {
        var params: [String: Any] = [:]
        switch self {
        case .sparklinesRate(let assetsId):
            params["id"] = assetsId
            break
        case .sparklinesProfit(let assetsId, let type):
            params["id"] = assetsId
            params["profit"] = type
            break
        case .sparklinesPower(let assetsId, let type):
            params["id"] = assetsId
            params["power"] = type
            break
        }
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
}
