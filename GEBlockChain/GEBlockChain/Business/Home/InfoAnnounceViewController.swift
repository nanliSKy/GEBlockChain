//
//  InfoAnnounceViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/23.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class InfoAnnounceViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 50
        // Do any additional setup after loading the view.
    }
}

extension InfoAnnounceViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: InfoAnnounceCell = tableView.dequeueReusableCell(for: indexPath)
       
        cell.info.text = ""
        cell.time.text = ""
        return cell
    }
}

extension InfoAnnounceViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension InfoAnnounceViewController {
    
    static func board(_ title: String) -> InfoAnnounceViewController {
        let vc: InfoAnnounceViewController = Board(.Main).destination(InfoAnnounceViewController.self) as! InfoAnnounceViewController
        vc.title = title
        return vc
    }
}
