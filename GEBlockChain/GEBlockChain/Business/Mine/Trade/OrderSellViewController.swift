//
//  OrderSellViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/19.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class OrderSellViewController: GEBaseViewController {

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



extension OrderSellViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TradeOrderCell = tableView.dequeueReusableCell(for: indexPath)
        
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
//        return 130
        return 194
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.navigationController?.pushViewController(TradeContainerViewController(), animated: true)
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

