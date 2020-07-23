//
//  GETabBarViewController.swift
//  GEBlockChain
//
//  Created by nanli on 2020/7/22.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class GETabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        createSubViewControllers()
        // Do any additional setup after loading the view.
    }
    
    func createSubViewControllers() {
        let home = GEHomeViewController.init()
        home.tabBarItem = configTabbarItem("首页", "Tab_Bar_Index", "Tab_Bar_Index_Selected")
        
        let home_nav = NavigationController(rootViewController: home)
        
        let market = GEMarketViewController.init()
        market.tabBarItem = configTabbarItem("交易市场", "Tab_Bar_Market", "Tab_Bar_Market_Selected")
        
        let market_nav = NavigationController(rootViewController: market)
        
        let info = GEInfoViewController.init()
        info.tabBarItem = configTabbarItem("资讯", "Tab_Bar_Info", "Tab_Bar_Info_Selected")
        
        let info_nav = NavigationController(rootViewController: info)
        
        let mine = GEMineViewController.init()
        mine.tabBarItem = configTabbarItem("我的", "Tab_Bar_Mine", "Tab_Bar_Mine_Selected")
        
        let mine_nav = NavigationController(rootViewController: mine)
        
        viewControllers = [home_nav, market_nav, info_nav, mine_nav]
        
    }
    
    func configTabbarItem(_ title: String, _ normalImage: String, _ selectImage: String) -> (UITabBarItem) {
        let item = UITabBarItem.init(title: title, image: UIImage.init(named: normalImage), selectedImage: UIImage.init(named: selectImage))
        return item
    }
}

