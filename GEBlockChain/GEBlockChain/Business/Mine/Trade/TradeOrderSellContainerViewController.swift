//
//  TradeOrderSellContainerViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/19.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import Parchment

class TradeOrderSellContainerViewController: GEBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        super.viewDidLoad()

        let viewControllers = [
            OrderSellViewController.board("全部", 0),
            OrderSellViewController.board("待收款", 1),
            OrderSellViewController.board("已成交", 2),
            OrderSellViewController.board("已取消", 3)
            ]
        
        let pagingViewController = PagingViewController(viewControllers: viewControllers)
        
        // Make sure you add the PagingViewController as a child view
        // controller and constrain it to the edges of the view.
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
        // Do any additional setup after loading the view.
    }
    
}


extension TradeOrderSellContainerViewController {
    static func boardC(_ title: String) -> TradeOrderSellContainerViewController {
        let vc: TradeOrderSellContainerViewController = TradeOrderSellContainerViewController()
        vc.title = title
        vc.view.backgroundColor = .white
        return vc
    }
}
