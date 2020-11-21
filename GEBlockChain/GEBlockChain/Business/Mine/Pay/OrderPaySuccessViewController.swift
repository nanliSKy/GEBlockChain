//
//  OrderPaySuccessViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/20.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class OrderPaySuccessViewController: GEBaseViewController {

    @IBOutlet weak var timeView: UILabel!
    @IBOutlet weak var banknoView: UILabel!
    @IBOutlet weak var numberView: UILabel!
    @IBOutlet weak var priveView: UILabel!
    @IBOutlet weak var checkAction: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}

extension OrderPaySuccessViewController {
    
    static func board(_ title: String) -> OrderPaySuccessViewController {
        let vc: OrderPaySuccessViewController = Board(.Pay).destination(OrderPaySuccessViewController.self) as! OrderPaySuccessViewController

        vc.title = title
        return vc
    }
    
}
