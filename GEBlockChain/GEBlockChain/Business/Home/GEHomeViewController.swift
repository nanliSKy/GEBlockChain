//
//  GEHomeViewController.swift
//  GEBlockChain
//
//  Created by nanli on 2020/7/22.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

import ReactiveSwift

import ReactiveCocoa

import SnapKit

import MJRefresh

class GEHomeViewController: GEBaseViewController {

    let manager = HomeBusinessVM()
    let business = MutableProperty<[Bussiness]?>(nil)
    let tableHeaderView = AssetsIndexTableHeaderView(frame: CGRect(x: 0, y: 0, width: Int.sw(), height: 374))
    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(cell: AssetCell.self)
        table.separatorStyle = .none
        table.backgroundColor = Pen.view(.backColor)
        table.rowHeight = 170.s6h()
        table.sectionHeaderHeight = 45
        return table
    }()
    
    var assets: [Bussiness] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hbd_barHidden = true
        view.backgroundColor = UIColor.white
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(view.snp.top)
        }
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak manager] in
            manager?.excuteIfPossible(nil)
        })
        
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { [weak manager] in
            manager?.excuteIfPossible(nil)
            
        })
       
 
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = tableHeaderView
     
        
        tableHeaderView.bannerView.setup(direction: .horizontal, item: { BannerItem() }, content: { (item, index) in
            item.imageView.image = UIImage(named: "banner")
        }, count: 1)


//
//        business <~ manager.action.values
//        business.producer.skipNil().startWithValues { [self] (business) in
//            self.assets = self.assets + business
//            self.tableView.reloadData()
//        }
        
        tableView.manage(by: manager)

        
       
//        button.reactive.pressed = CocoaAction(manager.action)
//
//        var observer: Signal<Int, Error>.Observer?
//        let signal = Signal<Int, Error> { (ob, lift) -> Void in
//            observer = ob
//        }
//
//        signal.observeResult { (result) in
//            if case let Result.success(value) = result {
//                print("success: \(value)")
//            }
//            if case let Result.failure(error) = result {
//                print("error: \(error)")
//            }
//        }
//
//
//        let subscriber = Signal<Int, Error>.Observer(value: { (input) in
//            print("接受值：\(input)")
//        }, failed: nil, completed: nil, interrupted: nil)
//
//        signal.observe(subscriber)
//        observer?.send(value: 5)
//
////        signalCreate()
//
////        generateSignalProducer()
//        basicAction()
    }
    
    
    func signalCreate() {
        
        let signalObserver = Signal<Int, Error>.Observer(value: { (value) in
            print("value: \(value)")
        }, failed: nil, completed: {
            print("done")
        }) {
            print("interrupter")
        }
        
        let (output, input) = Signal<Int, Error>.pipe()
        
        for i in 0 ..< 10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0*Double(i)) {
                input.send(value: i)
            }
        }
        
        output.observe(signalObserver)
        
//        let signalProducer: SignalProducer<Int, Error> = SignalProducer { (oberver, lifetime) in
//            for i in 0 ..< 10 {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0*Double(i)) {
//                    oberver.send(value: i)
//                    if i == 9 {
//                        oberver.sendCompleted()
//                    }
//                }
//            }
        
    }
    
}

extension GEHomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AssetCell.className()) as! AssetCell
//        cell.bussiness = assets[indexPath.row]
        cell.bussiness = manager.element(byRow: indexPath)
        return cell
    }
    
}

extension GEHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = AssetSectionView(frame: tableView.rectForHeader(inSection: section))
        return view
    }
}


final class HomeBusinessVM: ViewModel, TableViewHandler {
    
    func excuteIfPossible(_ obj:()?) {
        action.apply().start()
    }
    
    var error: Signal<String, Never> {action.errors.map {$0.description}}
    /// 数据源类型
    typealias DATASOURCE = [Bussiness]
    var dataSource: Property<[Bussiness]> { Property(capturing: list) }
    
    var list = MutableProperty(DATASOURCE())
    
    let net = Net<NetAssetsBusiness>()

    let account = MutableProperty<String?>(nil)

    let action: Action<Void, [Bussiness], NetError>
    

    

    init() {
        action = Action<(), [Bussiness], NetError> { [unowned net] _ in
            return net.detach(.getAssetsList, DATASOURCE.self)
        }
        
        list <~ action.values
       
        
    }
    
    
}

struct Bussiness: Decodable{
    let assetName: String?
    let highlights: String?
    let length: Int?
    let unit: Int?
    let earningsRate: String?
    let assetId: String?
    var unitStr: String {
        switch self.unit {
        case 1:
            return "\(self.unit!)" + "日".localized
        case 2:
            return "\(self.unit!)" + "个月".localized
        case 3:
            return "\(self.unit!)" + "年".localized
        default:
            return "\(self.unit!)" + "日".localized
        }
    }
    
    var earnStr: String {
        let rate = Float(self.earningsRate ?? "0")! * 100
        return String.init(format: "%.2f", rate) + "%"
    }
    
    private enum CodingKeys: String, CodingKey {
        case assetName, highlights, length, unit, earningsRate, assetId
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        assetName = try container.decodeIfPresent(String.self, forKey: .assetName)
        highlights = try container.decodeIfPresent(String.self, forKey: .highlights)
        length = try container.decodeIfPresent(Int.self, forKey: .length)
        unit = try container.decodeIfPresent(Int.self, forKey: .unit)
        earningsRate = try container.decodeIfPresent(String.self, forKey: .earningsRate)
        assetId = try container.decodeIfPresent(String.self, forKey: .assetId)
    }
}
