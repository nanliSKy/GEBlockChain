//
//  CommissionViewModel.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/25.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import ReactiveSwift

class CommissionViewModel: ViewModel, TableViewHandler {
    var error: Signal<String, Never> {commissionListAction.errors.map {$0.description}}
    

    let net = Net<NetCommissionBussiness>()
    
    /// 数据源类型
    typealias DATASOURCE = [TAssets]
    var dataSource: Property<DATASOURCE> { Property(capturing: list) }

    var list = MutableProperty(DATASOURCE())

    /// 当前页
    private lazy var currentPage = 1
    func executeIfPossible(orderBy: Int, sort: Int, header: Bool) {
        if header {
            self.list.value = []
            currentPage = 1
        }
        
        commissionListAction.apply((orderBy, sort, currentPage, 20)).start()
//        newsAction.apply((stations, currentPage, 20)).start()
       
    }
    
    let commissionListAction: Action<(Int, Int, Int, Int), TAssetsList, NetError>
    func dataHandle() {
        commissionListAction.values.observeValues { [unowned self] (newsList) in
            
            
            if self.currentPage <= newsList.size {
                self.list.value +=  newsList.list
            }else {
                self.list.value += []
                Toast.show(message: "无更多数据")
            }
            self.currentPage += 1
        }
        
        commissionListAction.errors.observeResult { (result) in
            print(result)
        }
        
    }
    
    init() {
        commissionListAction = Action{ [unowned net] ( orderBy, sort, page, size) in
             net.detach(.commissionList(orderBy, sort, page, size), TAssetsList.self) }
    }
}

