//
//  PlaceAnOrderViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/20.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class PlaceAnOrderViewController: GEBaseViewController {

//    private let menus: [String] = ["单   价：", "小   计：", "优惠券抵扣："]
    private let menus: [String] = ["单   价：", "小   计："]
    @IBOutlet weak var placeOrderView: PlaceAnOrder!
    
    @IBOutlet weak var priceView: UILabel!
    @IBOutlet weak var placeOrderAction: UIButton!
    @IBOutlet weak var numberView: UILabel!
    @IBOutlet weak var safeAction: UIButton!
    @IBOutlet weak var readAction: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var marketType: MarketType? = .subscriptType
    let viewModel = PlaceOrderViewModel()
    
    private var assets: TAssets? {
        didSet{
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "提交订单"
        
        placeOrderView.assets = assets
        
        safeAction.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] (sender) in
            self.navigationController?.pushViewController(CCCCViewController.boardC("相关协议和风险提示"), animated: true)
        }
        
        
        placeOrderView.number.signal.observeValues { [unowned self] (number) in
            self.numberView.text = "共\(number)块组件 需付"
            if let price = self.assets?.price {
                self.priceView.text = "\(Float(price)! * Float(number))"
            }
            self.tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .none)
            
        }
        
        //默认购买组建数量
        placeOrderView.number.value = 1
        self.placeOrderAction.backgroundColor = "#5C7186".colorful()
        self.placeOrderAction.isEnabled = false
        readAction.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] (sender) in
            sender.isSelected = !sender.isSelected
            self.placeOrderAction.backgroundColor = sender.isSelected ? Pen.view(.basement) : "#5C7186".colorful()
            self.placeOrderAction.isEnabled = sender.isSelected
        }
        
        
        placeOrderAction.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] (_) in
            self.placeOrderOperator()
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    private func placeOrderOperator() {
        
        if marketType == .subscriptType {
            subscriptOperator()
        }else if marketType == .tradeType {
            tradeOperator()
        }
        
    }

    private func subscriptOperator() {
        viewModel.placeOrderAction.values.observeValues { [unowned self] (order) in
            if let price = self.assets?.price {
                let amount = "\(Float(price)! * Float(placeOrderView.number.value))"
                self.navigationController?.pushViewController(OrderPaySuccessViewController.board(amount: amount, order: order), animated: true)
            }
            
        }
        
        viewModel.placeOrderAction.errors.observeResult { [unowned self] (result) in
            self.navigationController?.pushViewController(OrderPaySuccessViewController.board(amount: "0", order: nil), animated: true)
        }
        Toast.show(viewModel.placeOrderAction.errors)
        guard let assetId = assets?.assetId else {
            return
        }
        viewModel.placeOrderAction.apply((assetId, "\(self.placeOrderView.number.value)")).start()
    }
    
    private func tradeOperator() {
        
        viewModel.placeTradeOrderAction.values.observeValues { [unowned self] (order) in
            if let price = self.assets?.price {
                let amount = "\(Float(price)! * Float(placeOrderView.number.value))"
                self.navigationController?.pushViewController(OrderPaySuccessViewController.board(amount: amount, order: order, type: marketType), animated: true)
            }
            
        }
        viewModel.placeTradeOrderAction.errors.observeResult { [unowned self] (result) in
            self.navigationController?.pushViewController(OrderPaySuccessViewController.board(amount: "0", order: nil, type: marketType), animated: true)
        }
        
        Toast.show(viewModel.placeTradeOrderAction.errors)
        guard let assetId = assets?.commissionId else {
            return
        }
        viewModel.placeTradeOrderAction.apply((assetId, "\(self.placeOrderView.number.value)")).start()
    }
}

extension PlaceAnOrderViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OrderMenuCell = tableView.dequeueReusableCell(for: indexPath)
        cell.recommendView.isHidden = true
        cell.actionView.isHidden = true
        cell.menuView.textColor = "#FF2828".colorful()
        cell.titleView.text = menus[indexPath.row]
        
        if indexPath.row == 0 {
            cell.menuView.text = assets?.price
        }else if indexPath.row == 1 {
            if let price = self.assets?.price {
                cell.menuView.text = "\(Float(price)! * Float(placeOrderView.number.value))"
            }
        }
       
        return cell
    }
}

extension PlaceAnOrderViewController: UITableViewDelegate {
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 130
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
    }
}

extension PlaceAnOrderViewController {
    
    static func board(_ assets: TAssets?, type: MarketType? = .subscriptType) -> PlaceAnOrderViewController {
        let vc: PlaceAnOrderViewController = Board(.Pay).destination(PlaceAnOrderViewController.self) as! PlaceAnOrderViewController
        vc.assets = assets
        vc.marketType = type
        return vc
    }
    
}
