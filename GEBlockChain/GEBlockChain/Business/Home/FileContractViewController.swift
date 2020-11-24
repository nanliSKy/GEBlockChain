//
//  FileContractViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/23.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class FileContractViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 50
        // Do any additional setup after loading the view.
    }
    

}

extension FileContractViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FileContractCell = tableView.dequeueReusableCell(for: indexPath)
       
        cell.contract.text = ""
        return cell
    }
}

extension FileContractViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension FileContractViewController {
    
    static func board(_ title: String) -> FileContractViewController {
        let vc: FileContractViewController = Board(.Main).destination(FileContractViewController.self) as! FileContractViewController
        vc.title = title
        return vc
    }
}
