//
//  StationsChart.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/25.
//  Copyright © 2020 darchain. All rights reserved.
//

import Foundation

struct YearProfit: Decodable {
    
    /// 时间
    var date: TimeInterval? = 0
    
    /// 年化收益率
    var rate: String? = nil
    
    /// 发电量
    var quantity: String? = nil
    
    /// 收益
    var profit: String? = nil
    
    var rY: Double {
        return Double(rate ?? "0")!
    }

}

struct ChartsData: Decodable {
    let data: [YearProfit]
}
