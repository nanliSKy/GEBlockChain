//
//  OwnerAssets.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/26.
//  Copyright © 2020 darchain. All rights reserved.
//

import Foundation

struct OwnerAssetsConatiner: Decodable {
    let amount: String
    let profitNumber: String
    let selling: String
    let total: String
    let asset: OwnerAssetsList
}

struct OwnerAssetsList: Decodable {
    let size: Int
    let totle: Int
    let list: [OwnerAssets]
    
}

struct OwnerAssets: Decodable {
    let assetId: String
    let date: TimeInterval
    let profit: String
    let rate: String
    let selling: String
    let status: Int
    let title: String
    let totle: String
    
    var status_show: String {
        if status == 1 {
            return "收益中"
        }else if status == 2 {
            return "已到期"
        }else if status == 3 {
            return "失败"
        }else {
            return "认购中"
        }
    }
    
    
}
