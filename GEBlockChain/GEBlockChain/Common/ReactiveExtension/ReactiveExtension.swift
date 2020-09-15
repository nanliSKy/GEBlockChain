//
//  ReactiveExtension.swift
//  GEBlockChain
//
//  Created by nan li on 2020/9/7.
//  Copyright © 2020 darchain. All rights reserved.
//

import ReactiveSwift

extension PropertyProtocol where Value: Collection {
    
    /// 数据数量
    public var count: Property<Int> {
        return map {$0.count}
    }
    
    /// 数据是否为空
    public var isEmpty: Property<Bool> {
        return map {$0.isEmpty}
    }
}
