//
//  PendOrderViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/27.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import MJRefresh

class PendOrderViewController: GEBaseViewController {
    
    
    private let manager = PendListViewModel()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 130
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [unowned manager] in
            manager.executeIfPossible(header: true)
        })
        
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { [unowned manager] in
            manager.executeIfPossible(header: false)
            
        })
        
        manager.executeIfPossible(header: true)
        tableView.manage(by: manager)

        manager.dataHandle()
        // Do any additional setup after loading the view.
    }
    


}




extension PendOrderViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return manager.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeAssestsCell = tableView.dequeueReusableCell(for: indexPath)
        guard let asset = manager.element(at: indexPath.section) else { return cell }
        
        cell.assets = asset
        if asset.status == 1 {
            cell.stateView.image = UIImage(named: "state_trade_successful")
        }else if asset.status == 2 {
            cell.stateView.image = UIImage(named: "state_trade_fail")
        }else if asset.status == 3 {
            cell.stateView.image = UIImage(named: "state_trade_successful")
        }
        
        return cell
    }
}

extension PendOrderViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: tableView.rectForHeader(inSection: section))
        view.backgroundColor = Pen.view(.tableBackgroundColor)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let asset = manager.element(at: indexPath.section) else { return }
        let vc: IndexProjectViewController = IndexProjectViewController.boardOwner(asset.assetId!, status: 10000)
        vc.commissionId = asset.commissionId
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension PendOrderViewController {

    static func board(_ title: String) -> PendOrderViewController {
        let vc: PendOrderViewController = Board(.Main).destination(PendOrderViewController.self) as! PendOrderViewController
        vc.title = title
        vc.view.backgroundColor = .white
        return vc
    }

    static func boardC(_ title: String, _ index: Int) -> PendOrderViewController {
        let vc: PendOrderViewController = PendOrderViewController()
        vc.title = title
        vc.view.backgroundColor = .white
        return vc
    }
}



