//
//  OrderCommissionViewModel.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/26.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import ReactiveSwift

class OrderCommissionViewModel: ViewModel {
    let net = Net<NetOrderBussiness>()
    
    /// 挂单获取参考价格
    private(set) lazy var orderPriceAction = Action<String, String, NetError> { [unowned net, unowned self] (assetId) -> SignalProducer<String, NetError> in
        return net.detach(.orderPrice(assetId), String.self)
    }
    
    private(set) lazy var orderCommissionAction = Action<(String, String, String), OrderCommsion, NetError> { [unowned net, unowned self] (assetId, price, quantity) -> SignalProducer<OrderCommsion, NetError> in
        return net.detach(.orderCommission(assetId, price, quantity), OrderCommsion.self)
    }
}


struct OrderCommsion: Decodable {
    let commissionId: String
}
