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
//        headerView.backClick.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] (sender) in
//            LoginViewController.showLoginVC(self)
//        }
        headerView.tap.reactive.stateChanged.observeValues { [unowned self] (tap) in
            LoginViewController.showLoginVC(self)
        }

        NotificationCenter.default.addObserver(self, selector: #selector(getFundProfit), name: Notification.Name(NOTILOGINSUCCESS), object: nil)
        getFundProfit()
        
    }
    
    
    /// 获取资产概况
    @objc private func getFundProfit() {
        let viewModel = FundViewModel()
        viewModel.fundProfit.values.observeValues { [unowned self] (profit) in
            self.headerView.profit = profit
        }
        viewModel.fundProfit.errors.observeResult { (result) in
            if case let Result.success(value) = result {
                if case let NetError.business(b) = value {
                    if b.code == -2 {
                        print(b.code)
                    }
                }
            }
        }
        viewModel.fundProfit.apply().start()
        
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
                
            guard UserDefaults.standard.string(forKey: UTOKEN) != nil else {
                LoginViewController.showLoginVC(self)
                return
            }
            switch index {
                case 0:
                    self.navigationController?.pushViewController(AssetsBalanceViewController.board("账户余额"), animated: true)
                    break
                case 1:
                    self.navigationController?.pushViewController(AssetsOwnerViewController.board("我的资产"), animated: true)
                    break
                case 2:
                    self.navigationController?.pushViewController(AssetsBalanceViewController.board("账户余额"), animated: true)
                    break
                case 3:
                    self.navigationController?.pushViewController(AssetsBalanceViewController.board("账户余额"), animated: true)
                    break
            case 4:
                self.navigationController?.pushViewController(PendOrderViewController.board("我的挂单"), animated: true)
                break
                    
            default:
                    self.navigationController?.pushViewController(AssetsOwnerViewController.board("我的资产"), animated: true)
                    break
                }
            }
            return cell
        }
        
        let cell: MineOrderTableViewCell = MineOrderTableViewCell.init(style: .default, reuseIdentifier: "Cell\(indexPath.row)")
            cell.isTradeOrder = indexPath.row == 1 ? false : true
            cell.selectControllerIndex.signal.observeValues { [unowned self] (isTradeOrder, index) in
                if indexPath.row == 1 {
                    self.navigationController?.pushViewController(SubscribeOwnerContainerViewController.boardC(index), animated: true)
                }else {
                    self.navigationController?.pushViewController(TradeOrderContainerViewController(), animated: true)
                }
            
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
