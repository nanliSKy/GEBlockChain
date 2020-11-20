//
//  TradeViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/19.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class TradeViewController: GEBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var sortTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var sortView: UIView!
    
    let arrorContainer = TradeArrorContainer(frame: .zero)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        sortTopConstraint.constant = Device.navBarHeight
        sortView.addSubview(arrorContainer)
        
        arrorContainer.mergeBind()?.observeValues({ (index, state) in
            print("\(index) : \(state)")
        })
        
        
    }
    
    
    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
        
        arrorContainer.snp.makeConstraints { (make) in
            make.edges.equalTo(sortView)
        }
        let topLineView = UIView()
        topLineView.backgroundColor = "#F2F2F2".colorful()
        sortView.addSubview(topLineView)
        topLineView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(sortView)
            make.height.equalTo(5)
        }
    }
    
}



extension TradeViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeAssestsCell = tableView.dequeueReusableCell(withIdentifier: "HomeAssestsCell") as! HomeAssestsCell
        
        return cell
    }
}

extension TradeViewController: UITableViewDelegate {
    
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


extension TradeViewController {
    
    static func board(_ title: String) -> TradeViewController {
        let vc: TradeViewController = Board(.Main).destination(TradeViewController.self) as! TradeViewController
        vc.title = title
        return vc
    }
    
    static func boardC(_ title: String) -> TradeViewController {
        let vc: TradeViewController = TradeViewController()
        vc.title = title
        vc.view.backgroundColor = .white
        return vc
    }
}


