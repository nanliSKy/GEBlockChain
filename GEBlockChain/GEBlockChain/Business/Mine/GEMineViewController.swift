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
       let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(cell: AssetCell.self)
        tableView.separatorStyle = .none
        tableView.backgroundColor = "#FBFCFE".colorful()
        tableView.sectionHeaderHeight = 45
        tableView.register(MineTableViewCell.self)
        tableView.register(MineOrderTableViewCell.self)
        return tableView
    }()
    
    private lazy var headerView: MineIntroView = {
        let view = MineIntroView()
        view.height = Device.compareHeightTo6s(228)
        return view
    }()
//    let mineTableHeaderView = MineTableHeaderView(frame: CGRect(x: 0, y: 0, width: Int.sw(), height: 245.s6h()))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hbd_barHidden = true
        view.backgroundColor = .white
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = Pen.view(.viewBackgroundColor)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(view)
        }
        
        tableView.tableHeaderView = headerView
        headerView.backClick.reactive.controlEvents(.touchUpInside).observeValues { [weak self] (sender) in
            LoginViewController.showLoginVC(self)
//            self?.present(LoginViewController.void(), animated: true, completion: nil)
        }
//        mineTableHeaderView.cert.reactive.controlEvents(.touchUpInside).observeValues { [weak self] (sender) in
//            self?.present(LoginViewController.void(), animated: true, completion: nil)
//        }
        
    }
    

}

extension GEMineViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: MineTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
        
        let cell: MineOrderTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        cell.selectControllerIndex.signal.observeValues { [unowned self] (index) in
            self.navigationController?.pushViewController(TradeOrderContainerViewController(), animated: true)
            
        }
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
