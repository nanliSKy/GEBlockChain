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
    
    private var flow: AssetsFlow? = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "资金明细"
        
        guard let f = flow else { return }
        changeView.text = "\(f.symbol)\(f.amount)"
        changeView.textColor = f.color.colorful()
        titleTypeView.text = f.op
        typeView.text = f.inOut
        timeView.text = f.date.timeIntervalToStr(dateFormat: "yyyy-mm-dd")
        orderId.text = f.serial
        balanceView.text = "¥\(f.balance)"
        markView.text = f.remark
        // Do any additional setup after loading the view.
    }
    

}


extension AssetsInfoViewController {
    
    static func board(_ flow: AssetsFlow) -> AssetsInfoViewController {
        let vc: AssetsInfoViewController = Board(.Pay).destination(AssetsInfoViewController.self) as! AssetsInfoViewController

        vc.flow = flow
        return vc
    }
    
}
