//
//  SubscribeViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/19.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class SubscribeViewController: GEBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
//        tableView.separatorColor = .red
        
        
//        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 200

        // Do any additional setup after loading the view.
    }
    


}

extension SubscribeViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeAssestsCell = tableView.dequeueReusableCell(withIdentifier: "HomeAssestsCell") as! HomeAssestsCell
        
        return cell
    }
}

extension SubscribeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: tableView.rectForHeader(inSection: section))
        view.backgroundColor = Pen.view(.tableBackgroundColor)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.navigationController?.pushViewController(TradeContainerViewController(), animated: true)
    }
}



extension SubscribeViewController {
    
    static func board(_ title: String) -> SubscribeViewController {
        let vc: SubscribeViewController = Board(.Main).destination(SubscribeViewController.self) as! SubscribeViewController
        vc.title = title
        return vc
    }
    
    static func boardC(_ title: String) -> SubscribeViewController {
        let vc: SubscribeViewController = SubscribeViewController()
        vc.title = title
        vc.view.backgroundColor = .white
        return vc
    }
}

