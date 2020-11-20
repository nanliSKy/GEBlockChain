//
//  CCCCViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/19.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class CCCCViewController: GEBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}

extension CCCCViewController {
    
 
    
    static func boardC(_ title: String) -> CCCCViewController {
        let vc: CCCCViewController = CCCCViewController()
        vc.title = title
        vc.view.backgroundColor = .white
        return vc
    }
}
