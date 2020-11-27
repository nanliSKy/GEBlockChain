//
//  OwnerViewModel.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/26.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import ReactiveSwift

class OwnerViewModel: ViewModel, TableViewHandler {
    

    var error: Signal<String, Never> {ownerAssetsAction.errors.map {$0.description}}
    let net = Net<NetFundBussiness>()
    
    /// 数据源类型
    typealias DATASOURCE = [OwnerAssets]
    var dataSource: Property<DATASOURCE> { Property(capturing: list) }

    var list = MutableProperty(DATASOURCE())
    /// 当前页
    var ownerContainer: OwnerAssetsConatiner?
    private lazy var currentPage = 1
    func executeIfPossible(header: Bool) {
        if header {
            self.list.value = []
            currentPage = 1
        }
        ownerAssetsAction.apply((currentPage, 20)).start()
       
    }
    
    let ownerAssetsAction: Action<(Int, Int), OwnerAssetsConatiner, NetError>
    func dataHandle() {
        ownerAssetsAction.values.observeValues { [unowned self] (ownerContainer) in
            
            self.ownerContainer = ownerContainer
            if self.currentPage <= ownerContainer.asset.list.count {
                self.list.value +=  ownerContainer.asset.list
            }else {
                self.list.value += []
                Toast.show(message: "无更多数据")
            }
            self.currentPage += 1
        }
        
        ownerAssetsAction.errors.observeResult { (result) in
//            print(result)
        }
    }
    
    init() {
        ownerAssetsAction = Action{ [unowned net] (page, size) in
             net.detach(.ownerAssets(page, size), OwnerAssetsConatiner.self) }
    }
    
}
