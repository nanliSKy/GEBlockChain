//
//  FundViewModel.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/24.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import ReactiveSwift

class FundViewModel: ViewModel {

    let net = Net<NetFundBussiness>()
    
    private(set) lazy var fundProfit = Action<(), FundProfit, NetError> { [unowned net, unowned self] _ -> SignalProducer<FundProfit, NetError> in
        return net.detach(.profit, FundProfit.self)
    }
    
    private(set) lazy var fundBalance = Action<(), FundBalance, NetError> { [unowned net, unowned self] _ -> SignalProducer<FundBalance, NetError> in
        return net.detach(.balance, FundBalance.self)
    }
}
