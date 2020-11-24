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

    private lazy var assetsContainer = TAssetsList(totle: 0, size: 0, list: [])
    
    func executeIfPossible(_ page: Int, header: Bool) {
        if header {
            self.list.value = []
        }
        subscribeListAction.apply((assetsContainer.size, 20)).start()
    }
    
//    let subscribeListAction: Action<(Int, Int), DATASOURCE, NetError>
    let subscribeListAction: Action<(Int, Int), TAssetsList, NetError>

    func dataHandle() {
        subscribeListAction.values.observeValues { [weak self] (assetsList) in
            self?.assetsContainer.size = assetsList.size
            self?.list.value +=  assetsList.list
        }
        
        subscribeListAction.errors.observeResult { (result) in
            print(result)
        }
    }
    
    init() {
        subscribeListAction = Action{ [unowned net] (page, size) in
             net.detach(.assetSubscribeList(page, size), TAssetsList.self) }
//        list <~ subscribeListAction.values
    }
    
    
}
 


