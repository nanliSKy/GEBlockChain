//
//  SubscribeOwnerContainerViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/26.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import Parchment

class SubscribeOwnerContainerViewController: GEBaseViewController {

    private var index: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "我的认购"
        
        let viewControllers = [
            OrderSubscribeViewController.board("全部", 0),
            OrderSubscribeViewController.board("认购中", 1),
            OrderSubscribeViewController.board("已成功", 2),
            OrderSubscribeViewController.board("已取消", 3)
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


extension SubscribeOwnerContainerViewController {
    static func boardC(_ index: Int) -> SubscribeOwnerContainerViewController {
        let vc: SubscribeOwnerContainerViewController = SubscribeOwnerContainerViewController()
        vc.index = index
        vc.view.backgroundColor = .white
        return vc
    }
}
