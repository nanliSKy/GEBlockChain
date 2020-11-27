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

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "资金明细", style: .plain, target: self, action: #selector(getFundsList))
        
        getFundBalance()
        // Do any additional setup after loading the view.
    }
    
    @objc private func getFundsList() {
        self.navigationController?.pushViewController(AssetsFlowRecordViewController.board("资金明细"), animated: true)
    }
    
    private func getFundBalance() {
        let viewModel = FundViewModel()
        viewModel.fundBalance.values.observeValues { [unowned self] (balance) in
            balanceView.text = balance.avaliable
        }
        viewModel.fundBalance.apply().start()
    }

}

extension AssetsBalanceViewController {
    
    static func board(_ title: String) -> AssetsBalanceViewController {
        let vc: AssetsBalanceViewController = Board(.Pay).destination(AssetsBalanceViewController.self) as! AssetsBalanceViewController

        vc.title = title
        return vc
    }
    
}
