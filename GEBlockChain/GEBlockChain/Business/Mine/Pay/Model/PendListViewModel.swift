//
//  PendListViewModel.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/27.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import ReactiveSwift

class PendListViewModel: ViewModel , TableViewHandler {
    let net = Net<NetOrderBussiness>()
    
    var error: Signal<String, Never> {pendListAction.errors.map {$0.description}}
    
    /// 数据源类型
    typealias DATASOURCE = [TAssets]
    var dataSource: Property<DATASOURCE> { Property(capturing: list) }

    var list = MutableProperty(DATASOURCE())
    /// 当前页
    private lazy var currentPage = 1
    func executeIfPossible(header: Bool) {
        if header {
            self.list.value = []
            currentPage = 1
        }
        pendListAction.apply((currentPage, 20)).start()
       
    }
    
    let pendListAction: Action<(Int, Int), TAssetsList, NetError>
    func dataHandle() {
        pendListAction.values.observeValues { [unowned self] (assetList) in
            
            if self.currentPage <= assetList.list.count {
                self.list.value +=  assetList.list
            }else {
                self.list.value += []
//                Toast.show(message: "无更多数据")
            }
            self.currentPage += 1
        }
        
        pendListAction.errors.observeResult { (result) in
//            print(result)
        }
    }
    
    init() {
        pendListAction = Action{ [unowned net] (page, size) in
             net.detach(.orderPendList(page, size), TAssetsList.self) }
    }
    
    
    /// 挂单获取参考价格
    private(set) lazy var orderCommissonCancelAction = Action<String, Void, NetError> { [unowned net, unowned self] (commissionId) -> SignalProducer<Void, NetError> in
        return net.detach(.orderCommissionCancel(commissionId))
    }
    
}
