//
//  InfoAnnounceViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/23.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import MJRefresh

class InfoAnnounceViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var assetId: String?
    private var manager = NewsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 50
        
//        NotificationCenter.default.addObserver(self, selector: #selector(executeIfPossible), name: Notification.Name(NOTIINFOANNOUNCE), object: nil)
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [unowned manager, unowned self] in
            manager.executeIfPossible(self.assetId!, header: true)
        })
        
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { [unowned manager, unowned self] in
            manager.executeIfPossible(self.assetId!, header: false)
            
        })
        manager.executeIfPossible(assetId!, header: true)
        tableView.manage(by: manager)

        manager.dataHandle()
    }
    
//   @objc private func executeIfPossible(noti: Notification) {
//     if let header = noti.object as? Bool {
//        manager.executeIfPossible(assets!.assetId, header: header)
//    }
// }
}

extension InfoAnnounceViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: InfoAnnounceCell = tableView.dequeueReusableCell(for: indexPath)
        let news: StationsNews = manager.element(at: indexPath.row) ?? StationsNews(title: "", date: "")
        cell.info.text = news.title
        cell.time.text = news.date
        return cell
    }
}

extension InfoAnnounceViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news: StationsNews = manager.element(at: indexPath.row) ?? StationsNews(title: "", date: "")
        let warpContract = Contract(name: news.title, url: news.url)
        self.navigationController?.pushViewController(WebContrainerViewController.board(warpContract), animated: true)
    }
}

extension InfoAnnounceViewController {
    
    static func board(_ assetId: String) -> InfoAnnounceViewController {
        let vc: InfoAnnounceViewController = Board(.Main).destination(InfoAnnounceViewController.self) as! InfoAnnounceViewController
        vc.assetId = assetId
        return vc
    }
}
