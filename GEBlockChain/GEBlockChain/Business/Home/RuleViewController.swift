//
//  RuleViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/23.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class RuleViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonContent: UIButton!
    @IBOutlet weak var timeView1: UILabel!
    @IBOutlet weak var timeView2: UILabel!
    @IBOutlet weak var timeView3: UILabel!
    @IBOutlet weak var timeView4: UILabel!
    
    private var assetId: String?
    private let items: [String] = ["认购#若项目发行成功，则认购期结束次日开始计息，认购期购买的用户将以每日3%年化收益率作为认购期补偿。若发行失败，则退还所有认购款。", "买入#买入份额后的第二日开始计算收益。", "收益结算#产品收益每日会有估值，每月的第N个自然日进行收益结算。实际结算到账金额以当月电费收益为准。", "到期#产品理财时间结束用户将不再获得收益，用户本金将在2日内归还到用户的平台账户中。"]
    override func viewDidLoad() {
        super.viewDidLoad()

        buttonContent.set(image: UIImage(named: "order_indicator"), title: "详细说明".localized, titlePosition: .left,
                   additionalSpacing: 14, state: .normal)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        
        requeestStations()
        // Do any additional setup after loading the view.
    }

    
    private func requeestStations() {
        let manager = AssetsViewModel()
        manager.requestStationsAction.values.observeValues { [unowned self] (stations) in
            
        }
//        manager.requestStationsAction.apply(asset!.assetId).start()
        manager.requestStationsAction.apply("55922464").start()
    }
}

extension RuleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RuleIntroCell = tableView.dequeueReusableCell(for: indexPath)
        let intro = items[indexPath.row].components(separatedBy: "#")
        cell.intro.text = intro.first
        cell.introContent.text = intro.last
        return cell
    }
}

extension RuleViewController {
    
    static func board(_ assetId: String) -> RuleViewController {
        let vc: RuleViewController = Board(.Main).destination(RuleViewController.self) as! RuleViewController
        vc.assetId = assetId
        return vc
    }
}
