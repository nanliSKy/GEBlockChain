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
        view.height = 290
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
            make.top.left.right.equalTo(view)
            make.bottom.equalTo(view.snp.bottom).offset(-Device.tabBarHeight)
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: MineTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.selectControllerIndex.signal.observeValues { [unowned self] (isTradeOrder, index) in
            switch index {
                case 0:
                    self.navigationController?.pushViewController(AssetsBalanceViewController.board("账户余额"), animated: true)
                    break
                case 1:
                    self.navigationController?.pushViewController(AssetsFlowRecordViewController.board("资金明细"), animated: true)
                    break
                case 2:
                    self.navigationController?.pushViewController(PlaceAnOrderViewController.board("提交订单"), animated: true)
                    break
                case 3:
                    self.navigationController?.pushViewController(GEMarketViewController(), animated: true)
                    break
                    
            default:
                    self.navigationController?.pushViewController(AssetsOwnerViewController.board("我的资产"), animated: true)
                    break
                }
            }
            return cell
        }
        
        let cell: MineOrderTableViewCell = MineOrderTableViewCell.init(style: .default, reuseIdentifier: "Cell\(indexPath.row)")
            cell.isTradeOrder = indexPath.row == 1 ? true : false
            cell.selectControllerIndex.signal.observeValues { [unowned self] (isTradeOrder, index) in
                self.navigationController?.pushViewController(TradeOrderContainerViewController(), animated: true)
            
            }
        return cell
        
    }
}

extension GEMineViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 190
        }else {
            return 145
        }
    }
}
