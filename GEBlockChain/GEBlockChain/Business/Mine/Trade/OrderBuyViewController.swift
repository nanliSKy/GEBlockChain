//
//  OrderBuyViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/19.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class OrderBuyViewController: GEBaseViewController {

    
    /// 订单状态，根据订单状态取值
    private var index: Int = 0
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 130
        // Do any additional setup after loading the view.
    }
    


}




extension OrderBuyViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TradeOrderCell = tableView.dequeueReusableCell(for: indexPath)
        
        cell.payOrderAction.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] (sender) in
            self.navigationController?.pushViewController(OrderCountPayViewController.board("订单支付"), animated: true)
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
//        return 130
        return 194
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.navigationController?.pushViewController(OrderEndSuccessViewController.board("订单支付"), animated: true)
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



