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
    var assetId: String? = ""
    
    /// 认购截止日期
    var date: TimeInterval? = 0
    
    /// 亮点
    var highlights: String? = ""
    
    /// 单价
    var price: String? = ""
    
    /// 年化收益
    var rate: String? = ""
    
    /// 已出售数量
    var sold: String? = "0"
    
    /// 状态
    var status: Int?
    
    /// 剩余发电时间
    let time: Int?
    
    /// 标题
    var title: String? = ""
    
    /// 总量
    
    var total: String? = "0"
    
    /// 挂单id
    var commissionId: String? = ""
    
    var orderId: String? = ""
    
    /// 购买数量
    var quantity: Int? = 0
    /// 挂单人
    var name: String? = ""
    
    /// 我的购入数量
    var myCount: String? = ""
    
    /// 总价
    var amount: String? = ""
    
    
    var left: String {
        return "\(Int(total ?? "0")! - Int(sold ?? "0")!)"
    }
    
    var time_show: String {
        guard let time = time else { return "" }
        return "\(time/365)年\(time%365)天"
    }
    
    var rate_show: String {
        return String(format: "%.2f%%", (Float(rate ?? "0") ?? 0) * 100)
//        return "\((Float(rate) ?? 0) * 100)%"
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case assetId, date, highlights, price, rate, sold, status, time, title, total, commissionId, name, myCount, amount, orderId, quantity
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        assetId = try container.decodeIfPresent(String.self, forKey: .assetId)
        highlights = try container.decodeIfPresent(String.self, forKey: .highlights)
        price = try container.decodeIfPresent(String.self, forKey: .price)
        rate = try container.decodeIfPresent(String.self, forKey: .rate)
        sold = try container.decodeIfPresent(String.self, forKey: .sold)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        total = try container.decodeIfPresent(String.self, forKey: .total)
        commissionId = try container.decodeIfPresent(String.self, forKey: .commissionId)
        date = try container.decodeIfPresent(TimeInterval.self, forKey: .date)
        status = try container.decodeIfPresent(Int.self, forKey: .status)
        time = try container.decodeIfPresent(Int.self, forKey: .time)
        myCount = try container.decodeIfPresent(String.self, forKey: .myCount)
        amount = try container.decodeIfPresent(String.self, forKey: .amount)
        orderId = try container.decodeIfPresent(String.self, forKey: .orderId)
        quantity = try container.decodeIfPresent(Int.self, forKey: .quantity)
    }

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


