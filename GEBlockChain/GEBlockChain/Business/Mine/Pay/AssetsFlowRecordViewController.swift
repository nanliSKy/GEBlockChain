//
//  AssetsFlowRecordViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/20.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class AssetsFlowRecordViewController: GEBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}

extension AssetsFlowRecordViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AssetsFlowCell = tableView.dequeueReusableCell(for: indexPath)
        
        return cell
    }
}

extension AssetsFlowRecordViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: tableView.rectForHeader(inSection: section))
        view.backgroundColor = Pen.view(.tableBackgroundColor)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.navigationController?.pushViewController(AssetsInfoViewController.board("资金明细"), animated: true)
    }
}

extension AssetsFlowRecordViewController {
    
    static func board(_ title: String) -> AssetsFlowRecordViewController {
        let vc: AssetsFlowRecordViewController = Board(.Pay).destination(AssetsFlowRecordViewController.self) as! AssetsFlowRecordViewController

        vc.title = title
        return vc
    }
    
}
