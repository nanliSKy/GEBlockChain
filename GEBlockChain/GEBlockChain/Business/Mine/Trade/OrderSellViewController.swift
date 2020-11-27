//
//  OrderSellViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/19.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import MJRefresh

class OrderSellViewController: GEBaseViewController {

    /// 订单状态，根据订单状态取值
    private var index: Int = 0
    
    private let manager = TransationSellListViewModel()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 130
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [unowned manager, unowned self] in
            manager.executeIfPossible(type: "\(self.index)", header: true)
        })
        
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { [unowned manager, unowned self] in
            manager.executeIfPossible(type: "\(index)", header: false)
            
        })
        
        manager.executeIfPossible(type: "\(self.index)", header: true)
        tableView.manage(by: manager)

        manager.dataHandle()
        // Do any additional setup after loading the view.
    }
    


}




extension OrderSellViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return manager.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TradeOrderCell = tableView.dequeueReusableCell(for: indexPath)
        guard let asset = manager.element(at: indexPath.section) else { return cell }
        
        cell.asset = asset
        cell.actionView.isHidden = true
        
        switch asset.status {
        case 1:
            cell.stateView.text = "待收款"
            break
        case 2:
            cell.stateView.text = "已成交"
            break
        case 3:
            cell.stateView.text = "已取消"
            break
        default:
            cell.stateView.text = "其他"
            break
        }
        
//        cell.payOrderAction.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] (sender) in
//            self.navigationController?.pushViewController(OrderCountPayViewController.board("订单支付"), animated: true)
//        }
//
//        cell.cancelOrderAction.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] (sender) in
//            self.navigationController?.pushViewController(OrderCancelViewController.board("订单支付"), animated: true)
//        }
        return cell
    }
}

extension OrderSellViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: tableView.rectForHeader(inSection: section))
        view.backgroundColor = Pen.view(.tableBackgroundColor)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
//        return 194
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.navigationController?.pushViewController(OrderEndSuccessViewController.board(orderId: ""), animated: true)
    }
}


extension OrderSellViewController {

    static func board(_ title: String, _ index: Int) -> OrderSellViewController {
        let vc: OrderSellViewController = Board(.Main).destination(OrderSellViewController.self) as! OrderSellViewController
        vc.title = title
        vc.index = index
        vc.view.backgroundColor = .white
        return vc
    }

    static func boardC(_ title: String, _ index: Int) -> OrderSellViewController {
        let vc: OrderSellViewController = OrderSellViewController()
        vc.title = title
        vc.index = index
        vc.view.backgroundColor = .white
        return vc
    }
}



