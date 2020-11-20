//
//  GEProjectDetailViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/16.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class GEProjectDetailViewController: GEBaseViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        tableView.dataSource = self
        tableView.register(DemoTableViewCell.self)
        // Do any additional setup after loading the view.
    }

}

extension GEProjectDetailViewController: UITableViewDataSource {
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DemoTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.textLabel?.text = "row {\(indexPath.row)}"
        return cell
    }
}
