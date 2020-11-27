//
//  OrderPaySuccessViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/20.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class OrderPaySuccessViewController: GEBaseViewController {

    @IBOutlet weak var statusIcon: UIImageView!
    @IBOutlet weak var statusIntro: UILabel!
    @IBOutlet weak var timeView: UILabel!
    @IBOutlet weak var banknoView: UILabel!
    @IBOutlet weak var numberView: UILabel!
    @IBOutlet weak var priveView: UILabel!
    @IBOutlet weak var checkAction: UIButton!
    
    var amount = ""
    var order: PlaceOrder?
    var type: MarketType? = .subscriptType
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "支付结果"
        
        
        
        numberView.text = "¥\(amount)"
        priveView.text = "¥\(amount)"
        
        checkAction.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] (_) in
            self.navigationController?.pushViewController(OrderEndSuccessViewController.board(orderId: self.order?.orderId ?? "", type: type), animated: true)
        }
        
        guard let order = order else {
            
            statusIcon.image = UIImage(named: "order_faiul")
            statusIntro.text = "交易失败"
            return
        }
        
        //一级市场隐藏查看订单
        if type == .subscriptType {
            checkAction.isHidden = true
        }else {
            timeView.isHidden = true
        }
        
        guard let valueDate = order.valueDate else { return }
        timeView.text = "预计\(valueDate.timeIntervalToStr(dateFormat: "yyyy-mm-dd"))开始计算收益"
        
        
    }
    

}

extension OrderPaySuccessViewController {
    
    static func board(amount: String, order: PlaceOrder?, type: MarketType? = .subscriptType) -> OrderPaySuccessViewController {
        let vc: OrderPaySuccessViewController = Board(.Pay).destination(OrderPaySuccessViewController.self) as! OrderPaySuccessViewController
        vc.amount = amount
        vc.order = order
        vc.type = type
        return vc
    }
    
}
