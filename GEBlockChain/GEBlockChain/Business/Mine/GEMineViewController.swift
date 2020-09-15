//
//  GEMineViewController.swift
//  GEBlockChain
//
//  Created by nanli on 2020/7/22.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

import ReactiveCocoa

import ReactiveSwift


class GEMineViewController: GEBaseViewController {

    let tableView: UITableView = {
       let table = UITableView(frame: .zero, style: .grouped)
        table.register(cell: AssetCell.self)
        table.separatorStyle = .none
        table.backgroundColor = "#FBFCFE".colorful()
        table.sectionHeaderHeight = 45
        table.register(cell: MineTableViewCell.self)
        table.register(cell: MineOrderTableViewCell.self)
        return table
    }()
    
    let mineTableHeaderView = MineTableHeaderView(frame: CGRect(x: 0, y: 0, width: Int.sw(), height: 245.s6h()))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hbd_barHidden = true
        view.backgroundColor = UIColor.white
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(view)
        }
        
        tableView.tableHeaderView = mineTableHeaderView
        mineTableHeaderView.cert.reactive.controlEvents(.touchUpInside).observeValues { [weak self] (sender) in
            self?.present(LoginViewController.void(), animated: true, completion: nil)
        }
        
    }
    

}

extension GEMineViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MineTableViewCell.className()) as! MineTableViewCell
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MineOrderTableViewCell.className()) as! MineOrderTableViewCell
        return cell
        
    }
}

extension GEMineViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 180.s6h()
        }else {
            return 130.s6h()
        }
    }
}
