//
//  RuleStations.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/25.
//  Copyright © 2020 darchain. All rights reserved.
//

import Foundation

struct StationsIntro: Decodable {
    
    /// 装机容量
    let capability: String
    
    /// 发电量
    let capacity: String
    
    /// 采集器品牌
    let collectorBrand: String
    
    /// 组件品牌
    let componentBrand: String
    
    /// 创建公司
    let create: String
    
    /// 并网日期
    let date: String
    
    /// 安装日期
    let installDate: String
    
    /// 逆变器品牌
    let inverterBrand: String
    
    /// 电站地址
    let location: String
    
    /// 组件型号
    let model: String
    
    /// 组件块数
    let number: String
    
    /// 运营公司
    let operation: String
    
    /// 电价
    let price: String
}

struct ProjectDate: Decodable {
    
    /// 到期时间
    let endDate: TimeInterval
    
    /// 认购结束时间
    let subEndDate: TimeInterval
    
    /// 认购开始时间
    let subStartDate: TimeInterval
    
    /// 起息日
    let valueDate: TimeInterval
    
}

struct ProjectRule: Decodable {
    let additionalProp1: String
    let additionalProp2: String
    let additionalProp3: String
}

struct Stations: Decodable {
    var description: String? = nil
    let detail: StationsIntro
    let projectDate: ProjectDate
    var rule: ProjectRule? = nil
}



/// 文件信息
struct Contract: Decodable {
    let name: String
    var url: String? = nil
}


/// 信息纰漏
struct StationsNews: Decodable {
    
    let title: String
    let date: String
    var url: String? = nil
}

struct NewsContainer: Decodable {
    let totle: Int
    var size: Int = 0
    let list: [StationsNews]
}
