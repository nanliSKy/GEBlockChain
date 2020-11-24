//
//  StationsViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/23.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class StationsHeaderView: UIView {
    let label: UILabel = {
        let l = UILabel()
        l.textColor = "#1F1F1F".colorful()
        l.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        l.text = "基本情况"
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let view = UIView()
        view.backgroundColor = "#DFE5ED".colorful()
        addSubview(view)
        view.snp.makeConstraints { (make) in
            make.width.height.equalTo(5)
            make.centerY.equalTo(self)
            make.left.equalTo(self.snp.left).offset(20)
        }
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(33)
            make.top.bottom.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class StationsViewController: UIViewController {

    private let items = [["装机总容量", "上网电价", "电站预计年发电量"], ["采集器品牌", "逆变器品牌", "组件品牌", "组件型号", "组件块数", "安装日期", "并网日期"], ["建站公司", "运营公司"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}

extension StationsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StationsIntroCell = tableView.dequeueReusableCell(for: indexPath)
        let intro = items[indexPath.section][indexPath.row].components(separatedBy: "#")
        cell.intro.text = intro.first
        return cell
    }
}

extension StationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view: StationsHeaderView = StationsHeaderView(frame: tableView.rectForHeader(inSection: section))
        if section == 0 {
            view.label.text = "基本情况"
        }else if section == 1 {
            view.label.text = "产品参数"
        }else if section == 2 {
            view.label.text = "持有信息"
        }
        return view
    }
    
}
extension StationsViewController {
    
    static func board(_ title: String) -> StationsViewController {
        let vc: StationsViewController = Board(.Main).destination(StationsViewController.self) as! StationsViewController
        vc.title = title
        return vc
    }
}
