//
//  ContractViewModel.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/25.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import ReactiveSwift

class ContractViewModel: ViewModel, TableViewHandler {
    
    var error: Signal<String, Never> {contractAction.errors.map {$0.description}}
    

    let net = Net<NetAssetsBusiness>()
    
    /// 数据源类型
    typealias DATASOURCE = [Contract]
    var dataSource: Property<DATASOURCE> { Property(capturing: list) }

    var list = MutableProperty(DATASOURCE())

    /// 当前页
    private lazy var currentPage = 0
    func executeIfPossible(stationsId: String) {
      
        contractAction.apply(stationsId).start()
       
    }
    
    let contractAction: Action<String, DATASOURCE, NetError>
    init() {
        contractAction = Action{ [unowned net] (stations) in
             net.detach(.getContract(stations), DATASOURCE.self) }
        list <~ contractAction.values
    } 
}
 



/// 信息纰漏
class NewsViewModel: ViewModel, TableViewHandler {
    var error: Signal<String, Never> {newsAction.errors.map {$0.description}}
    

    let net = Net<NetAssetsBusiness>()
    
    /// 数据源类型
    typealias DATASOURCE = [StationsNews]
    var dataSource: Property<DATASOURCE> { Property(capturing: list) }

    var list = MutableProperty(DATASOURCE())

    /// 当前页
    private lazy var currentPage = 0
    func executeIfPossible(_ stations: String, header: Bool) {
        if header {
            self.list.value = []
            currentPage = 0
        }
        newsAction.apply((stations, currentPage, 20)).start()
       
    }
    
    let newsAction: Action<(String, Int, Int), NewsContainer, NetError>
    func dataHandle() {
        newsAction.values.observeValues { [unowned self] (newsList) in
            
            
            if self.currentPage <= newsList.size {
                self.list.value +=  newsList.list
            }else {
                self.list.value += []
                Toast.show(message: "无更多数据")
            }
            self.currentPage += 1
        }
        
    }
    
    init() {
        newsAction = Action{ [unowned net] ( stationsId , page, size) in
             net.detach(.getAssetsNews(stationsId, page, size), NewsContainer.self) }
    }
}

