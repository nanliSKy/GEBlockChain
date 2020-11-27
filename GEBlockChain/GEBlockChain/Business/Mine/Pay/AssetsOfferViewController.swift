//
//  AssetsOfferViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/20.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class AssetsOfferViewController: GEBaseViewController {

    @IBOutlet weak var numberView: UITextField!
    @IBOutlet weak var priceView: UITextField!
    @IBOutlet weak var enableOfferView: UILabel!
    @IBOutlet weak var refferView: UILabel!
    @IBOutlet weak var numberAllAction: UIButton!
    @IBOutlet weak var refferUseAction: UIButton!
    @IBOutlet weak var confimAction: UIButton!
    
    let manager = OrderCommissionViewModel()
    var assetId: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "提交出售订单"
        
        confimAction.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] (sender) in
            self.submitCommsionOperator()
        }
        
        requestOrderPrice()
        
        // Do any additional setup after loading the view.
    }
    
    private func requestOrderPrice() {
        manager.orderPriceAction.values.observeValues { [unowned self] (price) in
            self.refferView.text = "参考价：\(price)"
        }
        manager.orderPriceAction.apply(assetId!).start()
    }
    
    private func submitCommsionOperator() {
//        if numberView.text?.count <= 0 {
//            Toast.show(message: "请输入挂单数量")
//            return
//        }
//        if priceView.text?.count! <= 0 {
//            Toast.show(message: "请输入挂单价格")
//            return
//        }
        
        manager.orderCommissionAction.values.observeValues { (order) in
            Toast.show(message: "交易成功")
        }
        Toast.show(manager.orderCommissionAction.errors)
        manager.orderCommissionAction.apply((assetId!, numberView.text!, priceView.text!)).start()
        
    }
}


extension AssetsOfferViewController {
    
    static func board(_ assetId: String) -> AssetsOfferViewController {
        let vc: AssetsOfferViewController = Board(.Pay).destination(AssetsOfferViewController.self) as! AssetsOfferViewController

        vc.assetId = assetId
        return vc
    }
    
}
