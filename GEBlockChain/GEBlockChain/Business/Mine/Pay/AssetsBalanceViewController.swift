//
//  AssetsBalanceViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/20.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class AssetsBalanceViewController: GEBaseViewController {

    @IBOutlet weak var withdrawAction: UIButton!
    @IBOutlet weak var rechargeAction: UIButton!
    @IBOutlet weak var balanceView: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}

extension AssetsBalanceViewController {
    
    static func board(_ title: String) -> AssetsBalanceViewController {
        let vc: AssetsBalanceViewController = Board(.Pay).destination(AssetsBalanceViewController.self) as! AssetsBalanceViewController

        vc.title = title
        return vc
    }
    
}
