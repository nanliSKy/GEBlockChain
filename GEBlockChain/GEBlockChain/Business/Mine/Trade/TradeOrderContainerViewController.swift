//
//  TradeOrderContainerViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/19.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

import Parchment


class TradeOrderContainerViewController: GEBaseViewController {

    private lazy var titleContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 44))
    let pagingViewController = NavigationBarPagingViewController(viewControllers: [
        TraderOrderBuyContrainerViewController.boardC("买单"),
        TradeOrderSellContainerViewController.boardC("卖单")
    ])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hbd_barHidden = false
        hbd_backInteractive = true
        view.backgroundColor = .white
        pagingViewController.borderOptions = .hidden
        pagingViewController.menuBackgroundColor = .clear
        pagingViewController.font = UIFont.systemFont(ofSize: 16)
        pagingViewController.selectedFont = UIFont.systemFont(ofSize: 18)
        pagingViewController.indicatorColor = Pen.view(.basement)
        pagingViewController.menuItemLabelSpacing = 0
        pagingViewController.menuItemSpacing = 35
        pagingViewController.textColor = "#444444".colorful()
        pagingViewController.selectedTextColor = Pen.view(.basement)
        
   
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        view.constrainToEdges(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        
        pagingViewController.indicatorOptions = PagingIndicatorOptions.visible(height: 3, zIndex: 0, spacing: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), insets: .zero)
        pagingViewController.collectionView.frame = CGRect(x: 0, y: 0, width: 150, height: 44)
        navigationItem.titleView = titleContainerView
        titleContainerView.addSubview(pagingViewController.collectionView)

    }
    
    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      guard let navigationBar = navigationController?.navigationBar else { return }
      navigationItem.titleView?.frame = CGRect(origin: .zero, size: navigationBar.bounds.size)
      pagingViewController.menuItemSize = .fixed(width: 40, height: 40)
      
        
      
      pagingViewController.collectionView.snp.makeConstraints { (make) in
            make.center.equalTo(titleContainerView)
            make.width.equalTo(150)
            make.height.equalTo(44)
        }
    }


}
