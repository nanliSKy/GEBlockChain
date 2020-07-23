//
//  LoginViewController.swift
//  GEBlockChain
//
//  Created by nanli on 2020/7/22.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class LoginViewController: GEBaseViewController {
    
    @IBOutlet weak var tfphone: UITextField!
    
    @IBOutlet weak var tfcode: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        hbd_barTintColor = UIColor.white
        
        
    }
    
    @IBAction func loginClick(_ sender: UIButton) {
        
    }
}


extension LoginViewController {
    static func void() -> LoginViewController {
       return Board(.Login).destination(LoginViewController.self) as! LoginViewController
    }
}
