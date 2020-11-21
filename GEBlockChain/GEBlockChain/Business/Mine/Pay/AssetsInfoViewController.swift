//
//  AssetsInfoViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/20.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class AssetsInfoViewController: GEBaseViewController {

    @IBOutlet weak var titleTypeView: UILabel!
    @IBOutlet weak var changeView: UILabel!
    @IBOutlet weak var typeView: UILabel!
    @IBOutlet weak var timeView: UILabel!
    @IBOutlet weak var markView: UILabel!
    @IBOutlet weak var orderId: UILabel!
    @IBOutlet weak var balanceView: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}


extension AssetsInfoViewController {
    
    static func board(_ title: String) -> AssetsInfoViewController {
        let vc: AssetsInfoViewController = Board(.Pay).destination(AssetsInfoViewController.self) as! AssetsInfoViewController

        vc.title = title
        return vc
    }
    
}
