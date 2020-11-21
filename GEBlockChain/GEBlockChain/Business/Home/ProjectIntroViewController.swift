//
//  ProjectIntroViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/17.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import LTScrollView

class ProjectIntroViewController: UIViewController {

    private lazy var headerView: IntroHeaderView = {
        let view = IntroHeaderView.init()
        return view
    }()
    
    private lazy var viewControllers: [UIViewController] = {
       return [RuleTableViewController(), RuleTableViewController(), RuleTableViewController(), RuleTableViewController()]
    }()
    
    private lazy var titles: [String] = {
        return ["规则介绍".localized, "电站详情".localized, "相关文件".localized, "信息披露".localized]
    }()
    
    private lazy var layout: LTLayout = {
        let layout = LTLayout()
        layout.isAverage = true
        layout.sliderWidth = 60
        layout.titleFont = UIFont.systemFont(ofSize: 15)
        layout.titleViewBgColor = UIColor.white
        layout.titleColor = UIColor(r: 178, g: 178, b: 178)
        layout.titleSelectColor = Pen.view(.basement)
        layout.bottomLineColor = Pen.view(.basement)
        layout.sliderHeight = 56
        return layout
    }()
    
    private lazy var advancedManager: LTAdvancedManager = {
        let statusBarH = UIApplication.shared.statusBarFrame.size.height
        let advancedManager = LTAdvancedManager(frame: CGRect(x: 0, y: Device.navBarHeight, width: Device.width, height: Device.height - Device.navBarHeight), viewControllers: viewControllers, titles: titles, currentViewController: self, layout: layout, headerViewHandle: {[weak self] in
            guard let strongSelf = self else { return UIView() }
            let headerView = strongSelf.headerView
            return headerView
        })
        /* 设置代理 监听滚动 */
        advancedManager.delegate = self
     
        return advancedManager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hbd_tintColor = .white
        hbd_barShadowHidden = true
        hbd_barTintColor = Pen.view(.basement)
        hbd_titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        
        self.automaticallyAdjustsScrollViewInsets = false
        view.addSubview(advancedManager)
        advancedManagerConfig()

        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}



extension ProjectIntroViewController: LTAdvancedScrollViewDelegate {
    private func advancedManagerConfig() {
        advancedManager.advancedDidSelectIndexHandle = {
            print("选中了 -> \($0)")
        }
    }
    
    func glt_scrollViewOffsetY(_ offsetY: CGFloat) {
    }
}

extension ProjectIntroViewController {
    
    static func boardC(_ title: String) -> ProjectIntroViewController {
        let vc: ProjectIntroViewController = ProjectIntroViewController()
        vc.title = title
        return vc
    }
    
    
}
