//
//  GEHomeViewController.swift
//  GEBlockChain
//
//  Created by nanli on 2020/7/22.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit


import SnapKit
class GEHomeViewController: GEBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
//        hideNavigationBar = true
        
        
        hbd_barHidden = true
        
        let button = UIButton()
        button.backgroundColor = UIColor.red
        view.addSubview(button)
        button.addTarget(self, action: #selector(push), for: .touchUpInside)
        
        button.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 100, height: 30))
            make.center.equalTo(view)
        }
        
        
        
    }
    
    @objc func push() {
        navigationController?.pushViewController(LoginViewController.void(), animated: true)
    }

    

}
