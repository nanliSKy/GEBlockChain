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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        hbd_tintColor = .white
        hbd_barTintColor = Pen.view(.basement)
        hbd_titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        cancelOrderAction.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] (sender) in
            self.present(OrderCancelResonViewController.board(""), animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
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
    
    static func board(_ title: String) -> OrderCountPayViewController {
        let vc: OrderCountPayViewController = Board(.Pay).destination(OrderCountPayViewController.self) as! OrderCountPayViewController
        vc.title = title
        return vc
    }
    
}
