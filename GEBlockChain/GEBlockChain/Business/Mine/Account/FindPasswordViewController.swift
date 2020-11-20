//
//  FindPasswordViewController.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/17.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class FindPasswordViewController: GEBaseViewController {

    @IBOutlet weak var codeClicek: UIButton!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var tfCert: UITextField!
    @IBOutlet weak var tfCode: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }


    @IBAction func passwordClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        tfPassword.isSecureTextEntry = sender.isSelected
    }
    @IBAction func certClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        tfCert.isSecureTextEntry = sender.isSelected
    }
}


extension FindPasswordViewController {
    
    static func board() -> FindPasswordViewController {
       return Board(.Login).destination(FindPasswordViewController.self) as! FindPasswordViewController
    }
}
