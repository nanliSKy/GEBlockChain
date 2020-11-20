//
//  MineIntroView.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/17.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class MineIntroView: XibView {


    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var backClick: UIButton!
    @IBOutlet weak var certClick: UIButton!
    
    @IBOutlet weak var nameIntro: UILabel!
    
    @IBOutlet weak var balanceText: UILabel!
    
    @IBOutlet weak var waitEarnText: UILabel!
    
    @IBOutlet weak var yeterEarnText: UILabel!
    
    @IBAction func backupClick(_ sender: UIButton) {
        
    }
    
    override func draw(_ rect: CGRect) {
        viewBack.addTransitionColor(sc: "#0882FE".colorful(), ec: "#3999FB".colorful(), sp: CGPoint(x: 0, y: 0), ep: CGPoint(x: 1, y: 0))
    }
}
