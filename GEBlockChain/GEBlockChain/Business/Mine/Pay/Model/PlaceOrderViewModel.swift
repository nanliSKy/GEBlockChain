//
//  PlaceOrderViewModel.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/24.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import ReactiveSwift

class PlaceOrderViewModel: ViewModel {

    let net = Net<NetOrderBussiness>()
    
    
    /// 一级市场交易
    private(set) lazy var placeOrderAction = Action<(String, String), PlaceOrder, NetError> { [unowned net, unowned self] (assetId, quantity) -> SignalProducer<PlaceOrder, NetError> in
        return net.detach(.orderBuy(assetId, quantity), PlaceOrder.self)
    }
    
    private(set) lazy var placeOrderDetailAction = Action<String, PlaceOrderDetail, NetError> { [unowned net, unowned self] (orderId) -> SignalProducer<PlaceOrderDetail, NetError> in
        return net.detach(.orderDetail(orderId), PlaceOrderDetail.self)
    }
    
    /// 二级市场交易
    private(set) lazy var placeTradeOrderAction = Action<(String, String), PlaceOrder, NetError> { [unowned net, unowned self] (commissionId, quantity) -> SignalProducer<PlaceOrder, NetError> in
        return net.detach(.orderTradeBuy(commissionId, quantity), PlaceOrder.self)
    }
    
    private(set) lazy var placeTradeOrderDetailAction = Action<String, PlaceOrderDetail, NetError> { [unowned net, unowned self] (orderId) -> SignalProducer<PlaceOrderDetail, NetError> in
        return net.detach(.orderTradeDetail(orderId), PlaceOrderDetail.self)
    }
    
    
    /// 确认支付
    private(set) lazy var orderPayAction = Action<String, (), NetError> { [unowned net, unowned self] (orderId) -> SignalProducer<(), NetError> in
        return net.detach(.orderPay(orderId))
    }
    
    /// 取消交易支付
    private(set) lazy var orderPayCancelAction = Action<(String, String), String, NetError> { [unowned net, unowned self] (orderId, res) -> SignalProducer<String, NetError> in
        return net.detach(.orderPayCancel(orderId, res), String.self)
    }
    
    
}



struct PlaceOrder: Decodable {
    let orderId: String
    /// 预计收益时间
    var valueDate: TimeInterval?
}

/////认购单详情
//struct SubscribeDetail: Decodable {
//
//    /// 支付金额
//    let amount: String
//
//    /// 资产编号
//    let assetId: String
//
//    /// 下单时间
//    let date: TimeInterval
//
//    /// 数量
//    let quantity: String
//
//    /// 认购单号
//    let subscribeId: String
//
//    /// 标题
//    let title: String
//
//}


struct PlaceOrderDetail: Decodable {
    
    /// 资产编号
    let assetId: String
    
    /// 下单时间
    let date: TimeInterval
    
    /// 截止时间
    var expireDate: TimeInterval? = 0
    
    /// 订单编号
    var orderId: String? = ""
    
    /// 一级市场认购单号
    var subscribeId: String? = ""
    
    /// 价格
    var price: String? = ""
    
    /// 购买数量
    var quantity: Int? = 0
    
    /// 订单状态
    var status: Int? = 0
    
    /// 资产标题
    let title: String
    
    /// 总价
    var total: String? = ""
    
    /// 支付金额
    var amount: String? = ""
    
    
}
