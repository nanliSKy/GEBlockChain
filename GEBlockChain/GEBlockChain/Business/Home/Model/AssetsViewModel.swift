//
//  AssetsViewModel.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/24.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import ReactiveSwift

class AssetsViewModel: ViewModel, TableViewHandler {
    
    var error: Signal<String, Never> {subscribeListAction.errors.map {$0.description}}
    

    let net = Net<NetAssetsBusiness>()
    
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
        subscribeListAction.apply((currentPage, 20)).start()
       
    }
    
    let subscribeListAction: Action<(Int, Int), TAssetsList, NetError>
    func dataHandle() {
        subscribeListAction.values.observeValues { [unowned self] (assetsList) in
            
            
            if self.currentPage <= assetsList.size {
                self.list.value +=  assetsList.list
            }else {
                self.list.value += []
                Toast.show(message: "无更多数据")
            }
            self.currentPage += 1
        }
        
        subscribeListAction.errors.observeResult { (result) in
//            print(result)
        }
    }
    
    init() {
        subscribeListAction = Action{ [unowned net] (page, size) in
             net.detach(.assetSubscribeList(page, size), TAssetsList.self) }
//        list <~ subscribeListAction.values
    }
    
    private(set) lazy var requestStationsAction = Action<String, Stations, NetError> { [unowned net] (stationsId) -> SignalProducer<Stations, NetError> in
        return net.detach(.getStations(stationsId), Stations.self)
    }
    
    private(set) lazy var requestContractAction = Action<String, Contract, NetError> { [unowned net] (stationsId) -> SignalProducer<Contract, NetError> in
        return net.detach(.getContract(stationsId), Contract.self)
    }
    
    
    
}
 


