//
//  AssetsFlowViewModel.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/26.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import ReactiveSwift

class AssetsFlowViewModel: ViewModel, TableViewHandler {
    
    
    var error: Signal<String, Never> {assetsFlowAction.errors.map {$0.description}}
    let net = Net<NetFundBussiness>()
    
    /// 数据源类型
    typealias DATASOURCE = [AssetsFlow]
    var dataSource: Property<DATASOURCE> { Property(capturing: list) }

    var list = MutableProperty(DATASOURCE())

    private lazy var currentPage = 1
    func executeIfPossible(header: Bool) {
        if header {
            self.list.value = []
            currentPage = 1
        }
        assetsFlowAction.apply((currentPage, 20)).start()
       
    }
    
    let assetsFlowAction: Action<(Int, Int), AssetsFlowContainer, NetError>
    func dataHandle() {
        assetsFlowAction.values.observeValues { [unowned self] (assetFlow) in
            
            if self.currentPage <= assetFlow.list.count {
                self.list.value +=  assetFlow.list
            }else {
                self.list.value += []
                Toast.show(message: "无更多数据")
            }
            self.currentPage += 1
        }
        
        assetsFlowAction.errors.observeResult { (result) in
//            print(result)
        }
    }
    
    init() {
        assetsFlowAction = Action{ [unowned net] (page, size) in
             net.detach(.ownerFlowAssets(page, size), AssetsFlowContainer.self) }
    }
    
}


struct AssetsFlow: Decodable {
    let amount: String
    let balance: String
    let date: TimeInterval
    var remark: String? = ""
    let serial: String
    let type: Int
    
    var op: String {
        switch type {
        case 1:
            return "返本分红"
        case 2:
            return "优惠券"
        case 3:
            return "提现"
        case 4:
            return "购款返还"
        case 5:
            return "核算补贴"
        case 6:
            return "其他"
        case 7:
            return "出售电站"
        case 8:
            return "充值"
        case 9:
            return "购买电站"
        default:
            return ""
        }
    }
    var symbol: String {
        switch type {
        case 3:
            return "-"
        case 9:
            return "-"
        default:
            return "+"
        }
    }
    
    var color: String {
        switch type {
        case 3:
            return "#E89E04"
        case 9:
            return "#E89E04"
        default:
            return "#2AB735"
        }
    }
    
    var inOut: String {
        switch type {
        case 3:
            return "支出"
        case 9:
            return "支出"
        default:
            return "收入"
        }
    }
}


struct AssetsFlowContainer: Decodable {
    let size: Int
    let totle: Int
    let list: [AssetsFlow]
}
