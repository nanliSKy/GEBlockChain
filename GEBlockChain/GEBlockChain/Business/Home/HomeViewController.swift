//
//  HomeViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/19.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import ReactiveSwift
class HomeViewController: GEBaseViewController {

    @IBOutlet weak var headerView: HomeHeaderView!
    @IBOutlet weak var tableView: UITableView!
    private var list = [TAssets]()
    
    let viewModel = HomeAssetsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()


        let titleView = UILabel()
        titleView.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        titleView.textColor = Pen.label(.black)
        titleView.text = "首页"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleView)
//        navigationItem.titleView = UIStackView(arrangedSubviews: [titleView, UIView()])
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        addGestureClick()
        
        
//        viewModel.subscribeListAction.values.observeValues { [unowned self] (list) in
//            self.list = list
//            self.tableView.reloadData()
//        }
//        viewModel.subscribeListAction.values.observeResult { (result) in
//
//        }
        
        viewModel.executeIfPossible(nil)
        
        tableView.manage(by: viewModel)
        // Do any additional setup after loading the view.
    }
    
    
    func addGestureClick() {
        
        let friend = UITapGestureRecognizer()
        friend.reactive.stateChanged.observeValues { [unowned self] _ in
            self.navigationController?.pushViewController(CCCCViewController.boardC("邀请好友"), animated: true)

        }
        headerView.invateFriend.addGestureRecognizer(friend)
        
        let guider = UITapGestureRecognizer()
        guider.reactive.stateChanged.observeValues { [unowned self] _ in
            self.navigationController?.pushViewController(CCCCViewController.boardC("新手引导"), animated: true)
        }
        headerView.guider.addGestureRecognizer(guider)
        
        let safe = UITapGestureRecognizer()
        safe.reactive.stateChanged.observeValues { [unowned self] _ in
            self.navigationController?.pushViewController(CCCCViewController.boardC("安全保障"), animated: true)
        }
        headerView.safe.addGestureRecognizer(safe)
        
        headerView.moreAction.reactive.controlEvents(.touchUpInside).observeValues {  [unowned self] (sender) in
            self.navigationController?.pushViewController(SubscribeViewController.board("认购"), animated: true)
        }
    }
}

extension HomeViewController {
    
    static func board() -> HomeViewController {
       return Board(.Main).destination(HomeViewController.self) as! HomeViewController
    }
}


extension HomeViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
//        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeAssestsCell = tableView.dequeueReusableCell(for: indexPath)
        let assets = viewModel.element(at: indexPath.row)
        cell.assets = assets
//        let assets = self.list[indexPath.row]
//        print(assets)
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let assets = viewModel.element(at: indexPath.row) else { return  }
        self.navigationController?.pushViewController(IndexProjectViewController.boardC(assets.assetId!), animated: true)
    }
}
