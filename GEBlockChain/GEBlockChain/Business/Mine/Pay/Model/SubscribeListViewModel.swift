//
//  SubscribeListViewModel.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/26.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import ReactiveSwift

class SubscribeListViewModel: ViewModel, TableViewHandler {
    let net = Net<NetOrderBussiness>()
    
    var error: Signal<String, Never> {subscribeListAction.errors.map {$0.description}}
    
    /// 数据源类型
    typealias DATASOURCE = [TAssets]
    var dataSource: Property<DATASOURCE> { Property(capturing: list) }

    var list = MutableProperty(DATASOURCE())
    /// 当前页
    private lazy var currentPage = 1
    func executeIfPossible(type: String ,header: Bool) {
        if header {
            self.list.value = []
            currentPage = 1
        }
        subscribeListAction.apply((type, currentPage, 20)).start()
       
    }
    
    let subscribeListAction: Action<(String, Int, Int), TAssetsList, NetError>
    func dataHandle() {
        subscribeListAction.values.observeValues { [unowned self] (assetList) in
            
            if self.currentPage <= assetList.list.count {
                self.list.value +=  assetList.list
            }else {
                self.list.value += []
//                Toast.show(message: "无更多数据")
            }
            self.currentPage += 1
        }
        
        subscribeListAction.errors.observeResult { (result) in
//            print(result)
        }
    }
    
    init() {
        subscribeListAction = Action{ [unowned net] (type, page, size) in
             net.detach(.orderSubcribeList(type, page, size), TAssetsList.self) }
    }
}
