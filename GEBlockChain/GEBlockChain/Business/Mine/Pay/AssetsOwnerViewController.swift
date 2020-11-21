//
//  AssetsOwnerViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/20.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class AssetsOwnerViewController: GEBaseViewController {
    @IBOutlet weak var amountView: UILabel!
    @IBOutlet weak var assetsNumberView: UILabel!
    @IBOutlet weak var sellNumberView: UILabel!
    @IBOutlet weak var earnNumberView: UILabel!
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}

extension AssetsOwnerViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: AssetsOwnerCell = tableView.dequeueReusableCell(for: indexPath)
        
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
        
        self.navigationController?.pushViewController(OrderEndSuccessViewController.board("订单支付"), animated: true)
    }
}



extension AssetsOwnerViewController {
    
    static func board(_ title: String) -> AssetsOwnerViewController {
        let vc: AssetsOwnerViewController = Board(.Pay).destination(AssetsOwnerViewController.self) as! AssetsOwnerViewController

        vc.title = title
        return vc
    }
    
}
