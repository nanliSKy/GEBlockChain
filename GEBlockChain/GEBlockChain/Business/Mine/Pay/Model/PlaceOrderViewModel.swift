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
    
    private(set) lazy var placeOrderAction = Action<(String, String
), PlaceOrder, NetError> { [unowned net, unowned self] (assetId, quantity) -> SignalProducer<PlaceOrder, NetError> in
        return net.detach(.orderBuy(assetId, quantity), PlaceOrder.self)
    }
    
    private(set) lazy var placeOrderDetailAction = Action<String, PlaceOrderDetail, NetError> { [unowned net, unowned self] (orderId) -> SignalProducer<PlaceOrderDetail, NetError> in
        return net.detach(.orderDetail(orderId), PlaceOrderDetail.self)
    }
}



struct PlaceOrder: Decodable {
    let orderId: String
}

struct PlaceOrderDetail: Decodable {
    
    /// 资产编号
    let assetId: String
    
    /// 下单时间
    let date: TimeInterval
    
    /// 截止时间
    let expireDate: TimeInterval
    
    /// 订单编号
    let orderId: String
    
    /// 价格
    let price: String
    
    /// 购买数量
    let quantity: String
    
    /// 订单状态
    let status: Int
    
    /// 资产标题
    let title: String
    
    /// 总价
    let total: String
    
}
