//
//  TAssets.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/23.
//  Copyright © 2020 darchain. All rights reserved.
//

import Foundation

struct TAssets: Decodable {
    
    /// 资产id
    let assetId: String
    
    /// 认购截止日期
    let date: TimeInterval
    
    /// 亮点
    let highlights: String
    
    /// 单价
    let price: String
    
    /// 年化收益
    let rate: String
    
    /// 已出售数量
    let sold: String
    
    /// 状态
    var status: NSInteger
    
    /// 剩余发电时间
    let time: NSInteger
    
    /// 标题
    let title: String
    
    /// 总量
    
    let total: String
    
    var left: String {
        return "\(Int(total)! - Int(sold)!)"
    }
    
    var time_show: String {
        return "\(time/365)年\(time%365)天"
    }
    
    var rate_show: String {
        return String(format: "%.2f", (Float(rate) ?? 0) * 100)
//        return "\((Float(rate) ?? 0) * 100)%"
    }
    
    
//    private enum CodingKeys: String, CodingKey {
//        case assetId, date, highlights, price, rate, sold, status, time, title, total
//    }
    
//    private enum CodingKeys: String, CodingKey {
//        case date
//    }
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        date = try container.decodeIfPresent(String.self, forKey: .date)!
//
//    }

//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
////        assetId = try container.decodeIfPresent(String.self, forKey: .assetId)
//        date = try container.decodeIfPresent(String.self, forKey: .date)
//        highlights = try container.decodeIfPresent(String.self, forKey: .highlights)
//        price = try container.decodeIfPresent(String.self, forKey: .price)
////        rate = try container.decodeIfPresent(String.self, forKey: .rate)
//        sold = try container.decodeIfPresent(String.self, forKey: .sold)
////        status = try container.decodeIfPresent(String.self, forKey: .status)
////        time = try container.decodeIfPresent(String.self, forKey: .time)
//        title = try container.decodeIfPresent(String.self, forKey: .title)
//        total = try container.decodeIfPresent(String.self, forKey: .total)
//    }
}


struct TAssetsList: Decodable{
    
    let totle: Int
    var size: Int = 0
    let list: [TAssets]
    
}
