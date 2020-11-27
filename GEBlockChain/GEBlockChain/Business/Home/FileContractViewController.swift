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
    private var assetId: String?
    let manager = ContractViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 50
        
        
        manager.executeIfPossible(stationsId: assetId!)
        
        tableView.manage(by: manager)
        // Do any additional setup after loading the view.
    }
    


}

extension FileContractViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FileContractCell = tableView.dequeueReusableCell(for: indexPath)
        let contract = manager.element(at: indexPath.row)
        cell.contract.text = "《\(contract!.name)》"
        return cell
    }
}

extension FileContractViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contract = manager.element(at: indexPath.row)
        self.navigationController?.pushViewController(WebContrainerViewController.board(contract!), animated: true)
    }
}

extension FileContractViewController {
    
    static func board(_ assetId: String) -> FileContractViewController {
        let vc: FileContractViewController = Board(.Main).destination(FileContractViewController.self) as! FileContractViewController
        vc.assetId = assetId
        return vc
    }
}
