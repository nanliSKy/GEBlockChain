//
//  OrderBuyViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/19.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import MJRefresh
class OrderBuyViewController: GEBaseViewController {

    
    /// 订单状态，根据订单状态取值
    private var index: Int = 0
    
    private let manager = TransationBuyListViewModel()
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




extension OrderBuyViewController: UITableViewDataSource {
    
    
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
        
        switch asset.status {
        case 1:
            cell.stateView.text = "待付款"
        
            cell.stateView.backgroundColor = .white
            cell.stateView.layer.borderWidth = 1
            cell.stateView.textColor = "#FF2828".colorful()
            cell.stateView.layer.borderColor = "#FF2828".colorful().cgColor
            break
        case 2:
            cell.stateView.text = "已成交"
            cell.stateView.backgroundColor = Pen.view(.basement)
            cell.stateView.layer.borderWidth = 0
            cell.stateView.textColor = .white
            break
        case 3:
            cell.stateView.text = "已取消"
            cell.stateView.backgroundColor = "#D5D5D5".colorful()
            cell.stateView.layer.borderWidth = 0
            cell.stateView.textColor = .white
            break
        default:
            cell.stateView.text = "其他"
            cell.stateView.backgroundColor = Pen.view(.basement)
            cell.stateView.layer.borderWidth = 0
            cell.stateView.textColor = .white
            break
        }
        cell.actionView.isHidden = asset.status != 1
        cell.payOrderAction.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] (sender) in
            self.navigationController?.pushViewController(OrderCountPayViewController.board(asset), animated: true)
        }

        cell.cancelOrderAction.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] (sender) in
            self.navigationController?.pushViewController(OrderCancelViewController.board("订单支付"), animated: true)
        }
        return cell
    }
}

extension OrderBuyViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: tableView.rectForHeader(inSection: section))
        view.backgroundColor = Pen.view(.tableBackgroundColor)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let asset = manager.element(at: indexPath.section) else { return 130 }
        if asset.status == 1 {
            return 194
        }
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.navigationController?.pushViewController(OrderEndSuccessViewController.board(orderId: ""), animated: true)
    }
}


extension OrderBuyViewController {

    static func board(_ title: String, _ index: Int) -> OrderBuyViewController {
        let vc: OrderBuyViewController = Board(.Main).destination(OrderBuyViewController.self) as! OrderBuyViewController
        vc.title = title
        vc.index = index
        vc.view.backgroundColor = .white
        return vc
    }

    static func boardC(_ title: String, _ index: Int) -> OrderBuyViewController {
        let vc: OrderBuyViewController = OrderBuyViewController()
        vc.title = title
        vc.index = index
        vc.view.backgroundColor = .white
        return vc
    }
}



