//
//  OrderBuyViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/19.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class OrderBuyViewController: GEBaseViewController {

    private var index: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}

extension OrderBuyViewController {
    static func boardC(_ title: String, _ index: Int) -> OrderBuyViewController {
        let vc: OrderBuyViewController = OrderBuyViewController()
        vc.title = title
        vc.index = index
        vc.view.backgroundColor = .white
        return vc
    }
}
