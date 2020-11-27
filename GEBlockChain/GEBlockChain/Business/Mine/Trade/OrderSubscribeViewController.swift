//
//  OrderSubscribeViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/26.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import MJRefresh

class OrderSubscribeViewController: GEBaseViewController {

    /// 订单状态，根据订单状态取值
    private var index: Int = 0
    
    private let manager = SubscribeListViewModel()
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




extension OrderSubscribeViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return manager.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SubscribeOrderCell = tableView.dequeueReusableCell(for: indexPath)
        guard let asset = manager.element(at: indexPath.section) else { return cell }
        
        cell.assets = asset
    
        
//        cell.actionView.isHidden = true
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

extension OrderSubscribeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: tableView.rectForHeader(inSection: section))
        view.backgroundColor = Pen.view(.tableBackgroundColor)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.navigationController?.pushViewController(OrderEndSuccessViewController.board(orderId: ""), animated: true)
    }
}


extension OrderSubscribeViewController {

    static func board(_ title: String, _ index: Int) -> OrderSubscribeViewController {
        let vc: OrderSubscribeViewController = Board(.Main).destination(OrderSubscribeViewController.self) as! OrderSubscribeViewController
        vc.title = title
        vc.index = index
        vc.view.backgroundColor = .white
        return vc
    }

    static func boardC(_ title: String, _ index: Int) -> OrderSubscribeViewController {
        let vc: OrderSubscribeViewController = OrderSubscribeViewController()
        vc.title = title
        vc.index = index
        vc.view.backgroundColor = .white
        return vc
    }
}



