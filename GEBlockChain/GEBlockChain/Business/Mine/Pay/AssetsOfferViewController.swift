//
//  AssetsOfferViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/20.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class AssetsOfferViewController: GEBaseViewController {

    @IBOutlet weak var numberView: UITextField!
    @IBOutlet weak var priceView: UITextField!
    @IBOutlet weak var enableOfferView: UILabel!
    @IBOutlet weak var refferView: UILabel!
    @IBOutlet weak var numberAllAction: UIButton!
    @IBOutlet weak var refferUseAction: UIButton!
    @IBOutlet weak var confimAction: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}


extension AssetsOfferViewController {
    
    static func board(_ title: String) -> AssetsOfferViewController {
        let vc: AssetsOfferViewController = Board(.Pay).destination(AssetsOfferViewController.self) as! AssetsOfferViewController

        vc.title = title
        return vc
    }
    
}
