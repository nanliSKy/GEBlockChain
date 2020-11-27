//
//  TableView+Reactive.swift
//  GEBlockChain
//
//  Created by nan li on 2020/9/7.
//  Copyright © 2020 darchain. All rights reserved.
//

extension UITableView {
    
    
    /// 停止刷新
    /// - Parameter outOfData: 是否无更多数据
    func endRefresh(outOfData: Bool) {
        if let head = self.mj_header {
            head.endRefreshing()
        }
        if let foot = self.mj_footer {
            if outOfData {
                foot.endRefreshingWithNoMoreData()
            }else {
                foot.endRefreshing()
            }
        }
    }
}

extension UITableView {
    
    /// 列表刷新数据和数据处理
    /// - Parameter handler: handler
    func manage<T> (by handler: T) where T: TableViewHandler {
        
        
        self.reactive.reload <~ handler.megerValueWithError.observe(on: QueueScheduler.main)
        
        self.reactive.outOfData <~ handler.dataSource.isEmpty.signal.observe(on: QueueScheduler.main)
        
        
    }
}


import ReactiveSwift
import ReactiveCocoa

extension Reactive where Base == UITableView {
    
    /// 是否有数据，并结束刷新
    public var outOfData: BindingTarget<Bool> {
        return makeBindingTarget { (tableView, outOfData) in
            tableView.endRefresh(outOfData: outOfData)
        }
    }
    
    
    public var reload: BindingTarget<Bool> {
        return makeBindingTarget { (tableView, value) in
            DispatchQueue.main.async {
                if !value { return }
                if let head = tableView.mj_header {
                    head.endRefreshing()
                }
                
                tableView.reloadData()
            }
        }
    }
}



protocol TableViewHandler: RandomAccessCollection {
    associatedtype DATASOURCE: Collection
    
    /// 数据源
    var dataSource: Property<DATASOURCE> {get}
    
    /// 异常情况
    var error: Signal <String, Never> {get}
   
    
}


extension TableViewHandler {
    
    func index(after i: DATASOURCE.Index) -> DATASOURCE.Index {
        return dataSource.value.index(after: i)
    }
    
    subscript(position: DATASOURCE.Index) -> DATASOURCE.Element {
        get { return dataSource.value[position] }
        set { }
    }
    
    var startIndex: DATASOURCE.Index {
        return dataSource.value.startIndex
    }
    
    var endIndex: DATASOURCE.Index {
        return dataSource.value.endIndex
    }
}

extension TableViewHandler {
    fileprivate var megerValueWithError: Signal<Bool, Never> {
        return dataSource.signal.map(value: true).merge(with: error.map(value: true)).map { (b) -> Bool in
            return b
        }
    }
}

extension RandomAccessCollection where Index == Int {
    
    func element(byRow: IndexPath) -> Element? {
        return element(at: byRow.row)
    }
}

extension RandomAccessCollection where Index == Int {
    
    /// `index` 下的元素
    /// - Parameter index: 下标
    /// - Returns: Element
    public func element(at index: Index) -> Element? {
        guard indices.contains(index) else { return nil }
        return self[index]
    }
}
