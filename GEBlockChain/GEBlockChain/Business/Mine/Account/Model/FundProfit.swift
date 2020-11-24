//
//  FundProfit.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/24.
//  Copyright © 2020 darchain. All rights reserved.
//

import Foundation

struct FundProfit: Decodable{
    
    /// 资产折现
    let amount: String
    
    /// 账户余额
    let balance: String
    
    /// 累计收益
    let total: String
}


struct FundBalance: Decodable {
    
    /// 可使用余额
    let avaliable: String
    
    /// 冻结余额
    let freez: String
}
