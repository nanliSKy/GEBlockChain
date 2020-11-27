//
//  AssetsOwnerViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/20.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import MJRefresh
import ReactiveSwift

class AssetsOwnerViewController: GEBaseViewController {
    @IBOutlet weak var amountView: UILabel!
    @IBOutlet weak var assetsNumberView: UILabel!
    @IBOutlet weak var sellNumberView: UILabel!
    @IBOutlet weak var earnNumberView: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    let manager = OwnerViewModel()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak manager] in
            manager?.executeIfPossible(header: true)
        })
        
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { [weak manager] in
            manager?.executeIfPossible(header: false)
            
        })
        
        manager.executeIfPossible(header: true)
        tableView.manage(by: manager)

        manager.dataHandle()
        manager.ownerAssetsAction.completed.observeValues { [unowned self, unowned manager] (_) in
            self.amountView.text = manager.ownerContainer?.amount
            self.assetsNumberView.text = manager.ownerContainer?.total
            self.sellNumberView.text = manager.ownerContainer?.selling
            self.earnNumberView.text = manager.ownerContainer?.profitNumber
        }
        // Do any additional setup after loading the view.
    }
    

    private func requestOwnerAssets() {
        
    }

}

extension AssetsOwnerViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return manager.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: AssetsOwnerCell = tableView.dequeueReusableCell(for: indexPath)
        let ownerAssets = manager.element(at: indexPath.section)
        cell.ownerAssets = ownerAssets
        return cell
    }
}

extension AssetsOwnerViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: tableView.rectForHeader(inSection: section))
        view.backgroundColor = Pen.view(.tableBackgroundColor)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 130
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let asset = manager.element(at: indexPath.section) else { return }
        self.navigationController?.pushViewController(IndexProjectViewController.boardOwner(asset.assetId, status: 10001), animated: true)
        
//        let ownerAssets = manager.element(at: indexPath.section)
//        guard let asset = ownerAssets else { return  }
//        self.navigationController?.pushViewController(IndexProjectViewController.boardOwner(asset.assetId, status: asset.status), animated: true)
    }
}



extension AssetsOwnerViewController {
    
    static func board(_ title: String) -> AssetsOwnerViewController {
        let vc: AssetsOwnerViewController = Board(.Pay).destination(AssetsOwnerViewController.self) as! AssetsOwnerViewController

        vc.title = title
        return vc
    }
    
}
