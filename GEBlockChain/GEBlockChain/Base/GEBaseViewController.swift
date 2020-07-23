//
//  GEBaseViewController.swift
//  GEBlockChain
//
//  Created by nanli on 2020/7/22.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class GEBaseViewController: UIViewController {

   public init() {
       super.init(nibName: nil, bundle: nil)
   }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hbd_barShadowHidden = true
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .`default`
    }
    
    open func hiddenNavigationBar(_ hidden: Bool) {
        self.navigationController?.navigationBar.isHidden = hidden
    }
    
    deinit {
        print(self)
    }


}


