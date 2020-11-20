//
//  TradeContainerViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/19.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import Parchment

class NavigationBarPagingView: PagingView {
  
  override func setupConstraints() {
    // Use our convenience extension to constrain the page view to all
    // of the edges of the super view.
    constrainToEdges(pageView)
  }
}

// Create a custom paging view controller and override the view with
// our own custom subclass.
class NavigationBarPagingViewController: PagingViewController {
  override func loadView() {
    view = NavigationBarPagingView(
      options: options,
      collectionView: collectionView,
      pageView: pageViewController.view)
  }
}


class TradeContainerViewController: GEBaseViewController {

  
    private lazy var titleContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 44))
    let pagingViewController = NavigationBarPagingViewController(viewControllers: [
        SubscribeViewController.board("认购"),
        TradeViewController.board("交易")
    ])
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        // Make sure you add the PagingViewController as a child view
        // controller and contrain it to the edges of the view.
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        view.constrainToEdges(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        
        titleContainerView.isUserInteractionEnabled = true
        
          
        pagingViewController.collectionView.frame = CGRect(x: 0, y: 0, width: 150, height: 44)
        titleContainerView.addSubview(pagingViewController.collectionView)
        navigationItem.titleView = titleContainerView
     
//        navigationItem.titleView = pagingViewController.collectionView
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      guard let navigationBar = navigationController?.navigationBar else { return }
      navigationItem.titleView?.frame = CGRect(origin: .zero, size: navigationBar.bounds.size)
      pagingViewController.menuItemSize = .fixed(width: 50, height: navigationBar.bounds.height)
      
      pagingViewController.collectionView.snp.makeConstraints { (make) in
            make.center.equalTo(titleContainerView)
            make.width.equalTo(150)
            make.height.equalTo(44)
        }
    }


}
