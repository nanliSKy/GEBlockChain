//
//  NetOrderBussiness.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/24.
//  Copyright © 2020 darchain. All rights reserved.
//

enum NetOrderBussiness {
    case orderBuy(String, String)
    case orderTradeBuy(String, String)
    case orderDetail(String)
    case orderTradeDetail(String)
    case orderCommission(String, String, String)  //挂单
    case orderPrice(String) //获取参考价格
    case orderSubcribeList(String, Int, Int) //我的认购列表
    case orderTransationBuyList(String, Int, Int) //我的买单列表
    case orderTransationSellList(String, Int, Int) //我的卖单列表
    case orderPendList(Int, Int)   //我的挂单
    case orderCommissionCancel(String) //取消挂单
    case orderPay(String)   //确认支付
    case orderPayCancel(String, String) //取消支付
}


extension NetOrderBussiness : NetTargetType {
    
    var method: Method {
        switch self {
        case .orderBuy:
            return.post
        case .orderTradeBuy:
            return .post
        case .orderDetail:
            return .get
        case .orderTradeDetail:
            return .get
        case .orderCommission:
            return .post
        case .orderPrice:
            return .get
        case .orderSubcribeList:
            return .get
        case .orderTransationBuyList:
            return .get
        case .orderTransationSellList:
            return .get
        case .orderPendList:
            return .get
        case .orderCommissionCancel:
            return .get
        case .orderPay:
            return .get
        case .orderPayCancel:
            return .get
        
        }
        
    }
    
    public var path: String {
        switch self {
        case .orderBuy:
            return "order/buy"
        case .orderTradeBuy:
            return "order/buy"
        case .orderDetail:
            return "order/subscribe/detail"
        case .orderTradeDetail:
            return "order/buy/detail"
        case .orderCommission:
            return "order/commission"
        case .orderPrice:
            return "order/price"
        case .orderSubcribeList:
            return "order/subscribe/list"
        case .orderTransationBuyList:
            return "order/transaction/buy/list"
        case .orderTransationSellList:
            return "order/transaction/sell/list"
        case .orderPendList:
            return "order/commission/list"
        case .orderCommissionCancel:
            return "order/commission/cancel"
        case .orderPay:
            return "order/pay"
        case .orderPayCancel:
            return "order/transaction/cancel"
        }
    }
    
    public var task: Task {
        
        var params: [String: Any] = [:]
        switch self {
        case .orderBuy(let assetId, let quantity):
            params["assetId"] = assetId
            params["quantity"] = quantity
            break
        case .orderTradeBuy(let assetId, let quantity):
            params["commissionId"] = assetId
            params["quantity"] = quantity
            break
        case .orderDetail(let orderId):
            params["subscribeId"] = orderId
            break
        case .orderTradeDetail(let orderId):
            params["orderId"] = orderId
            break
        case .orderCommission(let assetId, let price, let quantity):
            params["assetId"] = assetId
            params["price"] = price
            params["quantity"] = quantity
            break
        case .orderPrice(let assetId):
            params["assrtId"] = assetId
            break
        case .orderSubcribeList(let type, let page, let size):
            params["type"] = type
            params["pageNumber"] = page
            params["pageSize"] = size
            break
        case .orderTransationBuyList(let type, let page, let size):
            params["type"] = type
            params["pageNumber"] = page
            params["pageSize"] = size
            break
        case .orderTransationSellList(let type, let page, let size):
            params["type"] = type
            params["pageNumber"] = page
            params["pageSize"] = size
            break
        case .orderPendList(let page, let size):
            params["pageNumber"] = page
            params["pageSize"] = size
            break
        case .orderCommissionCancel(let commissionId):
            params["commissionId"] = commissionId
            break
        case .orderPay(let orderId):
            params["orderId"] = orderId
            break
        case .orderPayCancel(let orderId, let res):
            params["orderId"] = orderId
            params["reason"] = res
            break
        }
        
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    
}



