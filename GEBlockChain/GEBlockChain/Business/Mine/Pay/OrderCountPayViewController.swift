//
//  OrderCountPayViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/20.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class OrderCountPayViewController: GEBaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var priceView: UILabel!
    @IBOutlet weak var timeView: UILabel!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var contentView: UILabel!
    @IBOutlet weak var cancelOrderAction: UIButton!
    @IBOutlet weak var payOrderAction: UIButton!
    private let menus: [String] = ["订单编号", "下单时间", "购买数量", "总价", "优惠券抵扣", "账户余额抵扣", "剩余支付"]
    private let manager = PlaceOrderViewModel()
    
    private var asset: TAssets?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "订单支付"

        hbd_tintColor = .white
        hbd_barTintColor = Pen.view(.basement)
        hbd_titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        contentView.text = asset?.title
        priceView.text = asset?.total
        cancelOrderAction.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] (sender) in
            self.present(OrderCancelResonViewController.board(""), animated: true, completion: nil)
        }
        
        payOrderAction.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] (_) in
            self.orderPayOperator()
        }
        
        // Do any additional setup after loading the view.
    }
    
    private func orderPayOperator() {
        manager.orderPayAction.values.observeValues { (oo) in
            print(oo)
        }
        
        Toast.show(manager.orderPayAction.errors)
        
        guard let orderId = asset?.orderId else { return  }
        manager.orderPayAction.apply(orderId).start()
    }
    
    private func orderPayCancelOperator() {
        manager.orderPayCancelAction.values.observeValues { (oo) in
            print(oo)
        }
        
        Toast.show(manager.orderPayCancelAction.errors)
        guard let orderId = asset?.orderId else { return  }
        manager.orderPayCancelAction.apply((orderId, "no")).start()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


extension OrderCountPayViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OrderMenuCell = tableView.dequeueReusableCell(for: indexPath)
        cell.titleView.text = menus[indexPath.row]
        if indexPath.row != 4 {
            cell.recommendView.isHidden = true
        }
        if  indexPath.row != 0 {
            cell.actionView.isHidden = true
        }
        if indexPath.row == 0 {
            cell.menuView.text = asset?.orderId
        }else if indexPath.row == 1 {
            cell.menuView.text = asset?.date?.timeIntervalToStr(dateFormat: "yyyy-mm-dd")
        }else if indexPath.row == 2 {
            cell.menuView.text = "\(asset?.quantity)"
        }else if indexPath.row == 3 {
            cell.menuView.text = asset?.total
        }else if indexPath.row == 4 {
            cell.menuView.text = "--"
        }else if indexPath.row == 5 {
            cell.menuView.text = asset?.total
        }else if indexPath.row == 6 {
            cell.menuView.text = "0"
        }
        return cell
    }
}

extension OrderCountPayViewController: UITableViewDelegate {
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 130
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
    }
}

extension OrderCountPayViewController {
    
    static func board(_ asset: TAssets) -> OrderCountPayViewController {
        let vc: OrderCountPayViewController = Board(.Pay).destination(OrderCountPayViewController.self) as! OrderCountPayViewController
        vc.asset = asset
        return vc
    }
    
}
