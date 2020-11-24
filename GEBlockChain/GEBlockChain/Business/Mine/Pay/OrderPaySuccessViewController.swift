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
    
    var amount = ""
    var orderId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "支付结果"
        
        numberView.text = "¥\(amount)"
        priveView.text = "¥\(amount)"
        
        checkAction.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] (_) in
            self.navigationController?.pushViewController(OrderEndSuccessViewController.board(orderId: self.orderId), animated: true)
        }
        // Do any additional setup after loading the view.
    }
    

}

extension OrderPaySuccessViewController {
    
    static func board(amount: String, orderId: String) -> OrderPaySuccessViewController {
        let vc: OrderPaySuccessViewController = Board(.Pay).destination(OrderPaySuccessViewController.self) as! OrderPaySuccessViewController
        vc.amount = amount
        vc.orderId = orderId
        return vc
    }
    
}
