//
//  IndexProjectViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/23.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import MJRefresh

enum MarketType {
    case subscriptType
    case tradeType
}

class IndexProjectViewController: UIViewController {
    
    private let manager = ChartVIewModel()
    
    private var marketType: MarketType? = .subscriptType
    
    var commissionId: String?
    private var assetsId: String? = ""
    /// 我的资产状态
    private var statu: Int? = 0
    private var asset: TAssets? {
        didSet {
            numberView.text = "剩余份额：\(asset?.left ?? "0")份"
            //公共
            if statu == 10000 {
                numberView.text = "剩余份额：\(asset?.left ?? "0")份"
                if asset?.status == 2 {
                    orderOperator.setTitle("已售罄", for: .normal)
                    orderOperator.backgroundColor = "#5C7186".colorful()
                    orderOperator.isUserInteractionEnabled = false
                }else if asset?.status == 3 {
                    orderOperator.setTitle("已下架", for: .normal)
                    orderOperator.backgroundColor = "#5C7186".colorful()
                    orderOperator.isUserInteractionEnabled = false
                }else {
                    orderOperator.backgroundColor = Pen.view(.basement)
                    orderOperator.isUserInteractionEnabled = true
                }
            }
            
            
        }
    }
    private lazy var headerView: IntroHeaderView = {
        let view = IntroHeaderView.init()
        return view
    }()
    
    private lazy var footerView: IndexFooterView = {
        let footView = IndexFooterView()
        return footView
    }()
    
    
    private lazy var segmentedControl: MASegmentedControl = {
        return MASegmentedControl()
    }()
    
    private lazy var viewControllers: [UIViewController] = {
        return [RuleViewController.board(assetsId!), StationsViewController.board(""), FileContractViewController.board(assetsId!), InfoAnnounceViewController.board(assetsId!)]
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    let numberView: UILabel = {
        let numberView = UILabel()
        numberView.textAlignment = .center
        numberView.font = UIFont.systemFont(ofSize: 14)
        numberView.text = "剩余份额：0份"
        numberView.textColor = "#F49E13".colorful()
        numberView.backgroundColor = "#FFC059".colorful().withAlphaComponent(0.4)
        return numberView
    }()
    
    let orderOperator: UIButton = {
        let button = UIButton()
        button.setTitle("立即购买", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Pen.view(.basement)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "项目详情"
        
//        headerView.assets = asset
        
        hbd_tintColor = .white
        hbd_barShadowHidden = true
        hbd_barTintColor = Pen.view(.basement)
        hbd_titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
//        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
//            NotificationCenter.default.post(name: Notification.Name(NOTIINFOANNOUNCE), object: true)
//        })
//        
//        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
//            NotificationCenter.default.post(name: Notification.Name(NOTIINFOANNOUNCE), object: false)
//        })
        
        
        
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.tableHeaderView = headerView
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(view)
        }
        
//        let bottomView = UIView()
//        view.backgroundColor = .white
//        view.addSubview(bottomView)
//        bottomView.snp.makeConstraints { (make) in
//            make.top.equalTo(tableView.snp.bottom)
//            make.left.right.bottom.equalTo(view)
//            make.height.equalTo(82)
//        }
//        bottomView.addSubview(numberView)
//        numberView.snp.makeConstraints { (make) in
//            make.left.right.top.equalTo(bottomView)
//            make.height.equalTo(24)
//        }
//
//        bottomView.addSubview(orderOperator)
//        orderOperator.snp.makeConstraints { (make) in
//            make.left.right.bottom.equalTo(bottomView)
//            make.top.equalTo(numberView.snp.bottom)
//        }
        
        view.addSubview(footerView)
        footerView.snp.makeConstraints { (make) in
            make.top.equalTo(tableView.snp.bottom)
            make.left.right.bottom.equalTo(view)
            make.height.equalTo(82)
        }
        footerView.status = statu!
        footerView.uoperator.signal.observeValues { [unowned self] (op) in
            if op == 0 || op == 1 {
                self.navigationController?.pushViewController(PlaceAnOrderViewController.board(self.asset, type: self.marketType), animated: true)
            }else if op == 3 {
                self.orderCommissonCancel()
            }else if op == 4 {
                self.navigationController?.pushViewController(AssetsOfferViewController.board(self.assetsId!), animated: true)
            }
        }
        
        
        orderOperator.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] (sender) in
            self.navigationController?.pushViewController(PlaceAnOrderViewController.board(self.asset, type: self.marketType), animated: true)
        }
        
        //切换Charts
        headerView.chartOperator.signal.observeValues { [unowned self] (index, type) in
            if index == 0 {
                self.requestSparklinesRate()
            }else if index == 1 {
                self.requestSparklinesProfit(type)
            }else if index == 2 {
                self.requestSparklinesPower(type)
            }
        }
        
        requestBaseAssets()
        //请求年化收益
        requestSparklinesRate()

    }
    
   @objc func segmemtedControlCC(_ segmented: MASegmentedControl) {
    
        tableView.reloadRows(at: [IndexPath(item: 0, section: 0)], with: .none)
    }

    private func updateOperator() {
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    private func requestBaseAssets() {
        let manager: HomeAssetsViewModel = HomeAssetsViewModel()
        manager.baseAssetsAction.values.observeValues { [unowned self] (assets) in
            self.asset = assets
            DispatchQueue.main.async {
                self.updateOperator()
                self.headerView.assets = asset
            }
        }
        manager.baseAssetsAction.apply(assetsId!).start()
    }
    
    private func requestSparklinesRate() {
        manager.yearProfitAction.values.observeValues { [unowned self] (chartData) in
            self.headerView.charts = chartData.data
        }
        manager.executeIfPossible(assetsId!)
    }
    
    private func requestSparklinesProfit(_ type: Int) {
        manager.sparklinesProfitAction.values.observeValues { [unowned self] (chartData) in
            self.headerView.charts = chartData.data
        }
        manager.sparklinesProfitAction.apply((assetsId!, type)).start()
    }
    
    private func requestSparklinesPower(_ type: Int) {
        manager.sparklinesPowerAction.values.observeValues { [unowned self] (chartData) in
            self.headerView.charts = chartData.data
        }
        manager.sparklinesPowerAction.apply((assetsId!, type)).start()
    }
    
    
    ///    取消挂单
    private func orderCommissonCancel() {
        let pend = PendListViewModel()
        pend.orderCommissonCancelAction.values.observeValues { (_) in
            Toast.show(message: "挂单已取消")
        }
        Toast.show(pend.orderCommissonCancelAction.errors)
        pend.orderCommissonCancelAction.apply(commissionId ?? "").start()
    }
}

extension IndexProjectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.selectionStyle = .none
      
        guard let view = viewControllers[segmentedControl.selectedSegmentIndex].view else { return  cell}
        cell.contentView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        addChild(viewControllers[segmentedControl.selectedSegmentIndex])
        didMove(toParent: viewControllers[segmentedControl.selectedSegmentIndex])
        return cell
    }
    
}

extension IndexProjectViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: tableView.rectForHeader(inSection: section))
        segmentedControl.frame = view.bounds
        view.addSubview(segmentedControl)
        segmentedControl.itemsWithText = true
        segmentedControl.fillEqually = true
        segmentedControl.bottomLineThumbView = true
        let strings = ["交易规则", "电站详情", "相关文件", "信息披露"]
        segmentedControl.setSegmentedWith(items: strings)
        segmentedControl.padding = 5
        
        segmentedControl.textColor = "#7A8FAC".colorful()
        segmentedControl.selectedTextColor = Pen.view(.basement)
        segmentedControl.thumbViewColor = Pen.view(.basement)
        segmentedControl.addTarget(self, action: #selector(segmemtedControlCC(_:)), for: .valueChanged)
        return view
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Device.height - 100
    }
}

extension IndexProjectViewController {
    
    static func boardC(_ assetsId: String, type: MarketType? = .subscriptType) -> IndexProjectViewController {
        let vc: IndexProjectViewController = IndexProjectViewController()
        if type == .subscriptType {
            vc.statu = 0
        }else if type == .tradeType {
            vc.statu = 1
        }
        vc.assetsId = assetsId
        vc.marketType = type
        return vc
    }
    
    static func boardOwner(_ assetsId: String, status: Int? = 0) -> IndexProjectViewController {
        let vc: IndexProjectViewController = IndexProjectViewController()
        vc.assetsId = assetsId
        vc.statu = status
        return vc
    }
}
