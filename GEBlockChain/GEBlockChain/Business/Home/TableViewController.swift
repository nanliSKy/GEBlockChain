//
//  TableViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/16.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(DemoTableViewCell.self)
        

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 20
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DemoTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.textLabel?.text = "Title \(indexPath.row)"
        return cell
    }

}
