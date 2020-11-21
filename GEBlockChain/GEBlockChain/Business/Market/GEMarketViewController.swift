//
//  GEMarketViewController.swift
//  GEBlockChain
//
//  Created by nanli on 2020/7/22.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class GEMarketViewController: GEBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        let progress = IQProgressBar.init(frame: .zero)
        progress.value = 0.5
        progress.progressColor = .red
        progress.backgroundColor = .green
        progress.spacing = 2
        progress.outlineWidth = 1
        view.addSubview(progress)
        progress.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(90)
            make.width.equalTo(300)
            make.height.equalTo(20)
        }
        
        let stripe = StripeProgressBar.init(frame: CGRect(x: 20, y: 400, width: 300, height: 10))
        stripe.layer.cornerRadius = 5
        stripe.progress = 0.5
        view.addSubview(stripe)
    }

}
