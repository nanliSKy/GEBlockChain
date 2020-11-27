//
//  ChartVIewModel.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/25.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import ReactiveSwift

class ChartVIewModel: ViewModel {
    

    let net = Net<NetChartBussiness>()
    
    /// 数据源类型
    typealias DATASOURCE = [YearProfit]
    var dataSource: Property<DATASOURCE> { Property(capturing: list) }

    var list = MutableProperty(DATASOURCE())

    func executeIfPossible(_ assetsId: String) {
        yearProfitAction.apply(assetsId).start()
    }
    
    let yearProfitAction: Action<String, ChartsData, NetError>
    func dataHandle() {
        yearProfitAction.values.observeValues { [unowned self] (chartsList) in
            self.list.value += chartsList.data
          
        }
    }
    
    init() {
        yearProfitAction = Action{ [unowned net] ( assetsId) in
             net.detach(.sparklinesRate(assetsId), ChartsData.self) }
    }
    
    /// 走势图,单份投资回报
    private(set) lazy var sparklinesProfitAction = Action<(String, Int), ChartsData, NetError> { [unowned net] (assetsId, type) -> SignalProducer<ChartsData, NetError> in
        return net.detach(.sparklinesProfit(assetsId, type), ChartsData.self)
    }
    
    /// 走势图,发电走势
    private(set) lazy var sparklinesPowerAction = Action<(String, Int), ChartsData, NetError> { [unowned net] (assetsId, type) -> SignalProducer<ChartsData, NetError> in
        return net.detach(.sparklinesPower(assetsId, type), ChartsData.self)
    }
}

