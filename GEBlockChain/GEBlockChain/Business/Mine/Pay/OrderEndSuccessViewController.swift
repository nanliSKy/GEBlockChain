//
//  OrderEndSuccessViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/20.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class OrderEndSuccessViewController: GEBaseViewController {

    private let menus: [String] = ["订单编号", "下单时间", "购买数量", "实际支付"]
    @IBOutlet weak var titleView: UILabel!
    
    @IBOutlet weak var appendAction: UIButton!
    @IBOutlet weak var sellAction: UIButton!
    @IBOutlet weak var titleContrainerView: UIView!
    private var orderId = ""
    private var order: PlaceOrderDetail?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "订单支付"
        hbd_tintColor = .white
        hbd_barTintColor = Pen.view(.basement)
        hbd_titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        getOrderDetail()
        // Do any additional setup after loading the view.
    }
    
    
    private func getOrderDetail() {
        let viewModel = PlaceOrderViewModel()
        viewModel.placeOrderDetailAction.values.observeValues { [unowned self] (order) in
            self.tableView.reloadData()
            print(order)
        }
        
        viewModel.placeOrderDetailAction.apply(orderId).start()
    }
}

extension OrderEndSuccessViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OrderMenuCell = tableView.dequeueReusableCell(for: indexPath)
        cell.titleView.text = menus[indexPath.row]
        cell.recommendView.isHidden = true
        cell.actionView.isHidden = true
        if indexPath.row == 0 {
            cell.menuView.text = order?.orderId
            cell.actionView.isHidden = false
            cell.actionView.reactive.controlEvents(.touchUpOutside).observeValues { [unowned self] (_) in
                let pastboard = UIPasteboard.general
                pastboard.string = self.order?.orderId
                Toast.show(message: "已复制")
            }
        }else if indexPath.row == 1 {
            cell.menuView.text = order?.date.timeIntervalToStr(dateFormat: nil)
        }else if indexPath.row == 2 {
            cell.menuView.text = order?.quantity
        }else if indexPath.row == 3 {
            cell.menuView.textColor = "#FF2828".colorful()
            cell.menuView.text = order?.total
        }
        return cell
    }
}

extension OrderEndSuccessViewController: UITableViewDelegate {
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 130
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
    }
}

extension OrderEndSuccessViewController {
    
    static func board(orderId: String) -> OrderEndSuccessViewController {
        let vc: OrderEndSuccessViewController = Board(.Pay).destination(OrderEndSuccessViewController.self) as! OrderEndSuccessViewController

        return vc
    }
    
}
