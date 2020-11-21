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

class IntroHeaderView: XibView {
    
    @IBOutlet weak var roundBackView: UIView!
    
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var rateView: UILabel!
    
    @IBOutlet weak var actionContainerView: UIView!
    @IBOutlet weak var numberView: UILabel!
    @IBOutlet weak var priceView: UILabel!
    @IBOutlet weak var timeView: UILabel!
    @IBOutlet weak var chartTitleView: UILabel!
    @IBOutlet weak var chartContainerView: UIView!
    @IBOutlet weak var chartCheckView: UIView!
    //    private var header: HeaderPowerView = {
//        let view = HeaderPowerView.init()
//        return view
//    }()
//
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        addSubview(header)
//        backgroundColor = .white
//        header.snp.makeConstraints { (make) in
//            make.edges.equalTo(self)
//        }
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
