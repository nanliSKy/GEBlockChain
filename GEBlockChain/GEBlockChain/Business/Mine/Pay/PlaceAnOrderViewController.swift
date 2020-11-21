//
//  PlaceAnOrderViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/20.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class PlaceAnOrderViewController: GEBaseViewController {

    private let menus: [String] = ["单   价：", "小   计：", "优惠券抵扣："]
    @IBOutlet weak var placeOrderView: PlaceAnOrder!
    
    @IBOutlet weak var priceView: UILabel!
    @IBOutlet weak var placeOrderAction: UIButton!
    @IBOutlet weak var numberView: UILabel!
    @IBOutlet weak var safeAction: UIButton!
    @IBOutlet weak var readAction: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        safeAction.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] (sender) in
            self.navigationController?.pushViewController(CCCCViewController.boardC("相关协议和风险提示"), animated: true)
        }
        // Do any additional setup after loading the view.
    }
    

}

extension PlaceAnOrderViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OrderMenuCell = tableView.dequeueReusableCell(for: indexPath)
        cell.titleView.text = menus[indexPath.row]
       
        return cell
    }
}

extension PlaceAnOrderViewController: UITableViewDelegate {
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 130
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
    }
}

extension PlaceAnOrderViewController {
    
    static func board(_ title: String) -> PlaceAnOrderViewController {
        let vc: PlaceAnOrderViewController = Board(.Pay).destination(PlaceAnOrderViewController.self) as! PlaceAnOrderViewController
        vc.title = title
        return vc
    }
    
}
