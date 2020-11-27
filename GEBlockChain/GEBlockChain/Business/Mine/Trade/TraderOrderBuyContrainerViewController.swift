//
//  TraderOrderBuyContrainerViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/19.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import Parchment

class TraderOrderBuyContrainerViewController: GEBaseViewController {

    private var index: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

//        title = "我的认购"
        
        let viewControllers = [
            OrderBuyViewController.board("全部", 0),
            OrderBuyViewController.board("待付款", 1),
            OrderBuyViewController.board("已成交", 2),
            OrderBuyViewController.board("已取消", 3)
            ]
        
        let pagingViewController = PagingViewController(viewControllers: viewControllers)

        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.menuItemSize = .fixed(width: Device.width/4.0, height: 44)
        pagingViewController.menuItemLabelSpacing = 0
        pagingViewController.indicatorOptions = PagingIndicatorOptions.visible(height: 3, zIndex: 0, spacing: UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30), insets: .zero)
//        view.constrainToEdges(pagingViewController.view)
        pagingViewController.view.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(view.snp.top).offset(Device.navBarHeight)
        }
        pagingViewController.didMove(toParent: self)
        pagingViewController.select(index: index)
        // Do any additional setup after loading the view.
    }
    
}

extension TraderOrderBuyContrainerViewController {
    static func boardC(_ title: String) -> TraderOrderBuyContrainerViewController {
        let vc: TraderOrderBuyContrainerViewController = TraderOrderBuyContrainerViewController()
        vc.title = title
        vc.view.backgroundColor = .white
        return vc
    }
}
