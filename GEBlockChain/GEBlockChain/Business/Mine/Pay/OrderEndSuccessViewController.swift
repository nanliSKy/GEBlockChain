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
    override func viewDidLoad() {
        super.viewDidLoad()

        hbd_tintColor = .white
        hbd_barTintColor = Pen.view(.basement)
        hbd_titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        // Do any additional setup after loading the view.
    }
}

extension OrderEndSuccessViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OrderMenuCell = tableView.dequeueReusableCell(for: indexPath)
        cell.titleView.text = menus[indexPath.row]
       
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
    
    static func board(_ title: String) -> OrderEndSuccessViewController {
        let vc: OrderEndSuccessViewController = Board(.Pay).destination(OrderEndSuccessViewController.self) as! OrderEndSuccessViewController

        vc.title = title
        return vc
    }
    
}
