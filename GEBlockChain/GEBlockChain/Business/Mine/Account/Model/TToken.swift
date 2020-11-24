//
//  TToken.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/23.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

struct TToken: Decodable {
    
    let token: String?
    private enum CodingKeys: String, CodingKey {
        case token
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        token = try container.decodeIfPresent(String.self, forKey: .token)
    }
}
