//
//  HomeViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/19.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class HomeViewController: GEBaseViewController {

    @IBOutlet weak var headerView: HomeHeaderView!
    @IBOutlet weak var tableView: UITableView!
    
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeAssestsCell = tableView.dequeueReusableCell(withIdentifier: "HomeAssestsCell") as! HomeAssestsCell
        
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.navigationController?.pushViewController(ProjectIntroViewController.boardC("项目详情"), animated: true)
    }
}
