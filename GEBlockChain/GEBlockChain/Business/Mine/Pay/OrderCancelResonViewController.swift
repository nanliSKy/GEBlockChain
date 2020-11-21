//
//  OrderCancelResonViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/20.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class OrderCancelResonViewController: GEBaseViewController {

    @IBOutlet weak var submitAction: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pageConcelAction: UIButton!
    
    private let menus: [String] = ["我不想买了", "拍多了或拍错了，重新拍", "支付金额不足", "忘记使用优惠券或余额", "优惠券抵扣", "其他原因"]
    
    private var intro: PopIntroducer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //        vc.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        self.intro = PopIntroducer.introduce(CGSize(width: Device.width, height: 450))
        self.modalPresentationStyle = UIModalPresentationStyle.custom
        self.transitioningDelegate = self.intro
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        pageConcelAction.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] (sender) in
            self.dismiss(animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }
    

}

extension OrderCancelResonViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OrderResonCancelCell = tableView.dequeueReusableCell(for: indexPath)
        cell.resonView.text = menus[indexPath.row]
       
        return cell
    }
}

extension OrderCancelResonViewController: UITableViewDelegate {
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 130
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
    }
}

extension OrderCancelResonViewController {
    
    static func board(_ title: String) -> OrderCancelResonViewController {
        let vc: OrderCancelResonViewController = Board(.Pay).destination(OrderCancelResonViewController.self) as! OrderCancelResonViewController

        vc.title = title
        return vc
    }
    
}
