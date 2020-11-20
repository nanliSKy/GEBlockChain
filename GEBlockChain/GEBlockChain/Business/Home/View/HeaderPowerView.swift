//
//  HeaderPowerView.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/16.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class HeaderPowerView: XibView {
        
}

class IntroHeaderView: UIView {
    
    private var header: HeaderPowerView = {
        let view = HeaderPowerView.init()
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(header)
        backgroundColor = .white
        header.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
