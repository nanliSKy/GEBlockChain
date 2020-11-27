//
//  TransationSellListViewModel.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/26.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import ReactiveSwift

class TransationSellListViewModel: ViewModel , TableViewHandler {
    let net = Net<NetOrderBussiness>()
    
    var error: Signal<String, Never> {transationSellListAction.errors.map {$0.description}}
    
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
        transationSellListAction.apply((type, currentPage, 20)).start()
       
    }
    
    let transationSellListAction: Action<(String, Int, Int), TAssetsList, NetError>
    func dataHandle() {
        transationSellListAction.values.observeValues { [unowned self] (assetList) in
            
            if self.currentPage <= assetList.list.count {
                self.list.value +=  assetList.list
            }else {
                self.list.value += []
//                Toast.show(message: "无更多数据")
            }
            self.currentPage += 1
        }
        
        transationSellListAction.errors.observeResult { (result) in
//            print(result)
        }
    }
    
    init() {
        transationSellListAction = Action{ [unowned net] (type, page, size) in
             net.detach(.orderTransationSellList(type, page, size), TAssetsList.self) }
    }
}
