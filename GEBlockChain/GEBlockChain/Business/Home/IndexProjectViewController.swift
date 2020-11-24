//
//  IndexProjectViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/23.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class IndexProjectViewController: UIViewController {
    
    private var asset: TAssets? {
        didSet {
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
    private lazy var headerView: IntroHeaderView = {
        let view = IntroHeaderView.init()
        return view
    }()
    private lazy var segmentedControl: MASegmentedControl = {
        return MASegmentedControl()
    }()
    
    private lazy var viewControllers: [UIViewController] = {
        return [RuleViewController.board(""), StationsViewController.board(""), FileContractViewController.board(""), InfoAnnounceViewController.board("")]
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
        
        headerView.assets = asset
        hbd_tintColor = .white
        hbd_barShadowHidden = true
        hbd_barTintColor = Pen.view(.basement)
        hbd_titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.tableHeaderView = headerView
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(view)
        }
        
        let bottomView = UIView()
        view.backgroundColor = .white
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(tableView.snp.bottom)
            make.left.right.bottom.equalTo(view)
            make.height.equalTo(82)
        }
        bottomView.addSubview(numberView)
        numberView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(bottomView)
            make.height.equalTo(24)
        }
        
        bottomView.addSubview(orderOperator)
        orderOperator.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(bottomView)
            make.top.equalTo(numberView.snp.bottom)
        }
        
        orderOperator.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] (sender) in
            self.navigationController?.pushViewController(PlaceAnOrderViewController.board(self.asset), animated: true)
        }
        

    }
    
   @objc func segmemtedControlCC(_ segmented: MASegmentedControl) {
        tableView.reloadRows(at: [IndexPath(item: 0, section: 0)], with: .none)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
    
    static func boardC(_ assets: TAssets) -> IndexProjectViewController {
        let vc: IndexProjectViewController = IndexProjectViewController()
        vc.asset = assets
        return vc
    }
}
