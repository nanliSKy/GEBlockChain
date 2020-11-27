//
//  HomeAssetsViewModel.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/23.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import ReactiveSwift

class HomeAssetsViewModel: ViewModel, TableViewHandler {
    var error: Signal<String, Never> {subscribeListAction.errors.map {$0.description}}
    

    let net = Net<NetAssetsBusiness>()
    
    /// 数据源类型
    typealias DATASOURCE = [TAssets]
    var dataSource: Property<DATASOURCE> { Property(capturing: list) }

    var list = MutableProperty(DATASOURCE())

    func executeIfPossible(_ obj: ()?) {
        subscribeListAction.apply().start()
    }
    
    let subscribeListAction: Action<(), DATASOURCE, NetError>

    init() {
        subscribeListAction = Action{ [unowned net] _ in
             net.detach(.preSubscriptList, DATASOURCE.self) }
        list <~ subscribeListAction.values
    }
    
    private(set) lazy var baseAssetsAction = Action<String, TAssets, NetError> { [unowned net] (assetsId) -> SignalProducer<TAssets, NetError> in
        return net.detach(.assetBaseDetail(assetsId), TAssets.self)
    }
    
//    private(set) lazy var subscribeListAction = Action<(), DATASOURCE, NetError> { [unowned net] _ in
//        return net.detach(.subscriptList, DATASOURCE.self)
//    }
}

