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
    @IBOutlet weak var openControl: UIButton!
    
    @IBOutlet weak var nameIntro: UILabel!
    
    @IBOutlet weak var balanceText: UILabel!
    
    @IBOutlet weak var waitEarnText: UILabel!
    @IBOutlet weak var certContainer: UIStackView!
    
    @IBOutlet weak var yeterEarnText: UILabel!
    
    let tap = UITapGestureRecognizer()
    @IBAction func backupClick(_ sender: UIButton) {
        
    }
    @IBAction func openOperator(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        update()
    }
    
    var profit: FundProfit? {
        didSet {
            update()
        }
    }
    
    
    override func loadedFromNib() {
        super.loadedFromNib()
        update()
    }
    
    private func update() {
        guard UserDefaults.standard.string(forKey: UTOKEN) != nil else {
            certContainer.isHidden = true

            nameIntro.text = "请登录"
            nameIntro.isUserInteractionEnabled = true
            nameIntro.addGestureRecognizer(tap)

            return
        }
        nameIntro.isUserInteractionEnabled = false
        nameIntro.text = UserDefaults.standard.string(forKey: UACCOUNT)
        balanceText.text = openControl.isSelected ? "****" : profit?.balance ?? "0"
        waitEarnText.text = openControl.isSelected ? "****" :  profit?.amount ?? "0"
        yeterEarnText.text = openControl.isSelected ? "****" :  profit?.total ?? "0"
    }
 
    
    override func draw(_ rect: CGRect) {
        viewBack.addTransitionColor(sc: "#0882FE".colorful(), ec: "#3999FB".colorful(), sp: CGPoint(x: 0, y: 0), ep: CGPoint(x: 1, y: 0))
    }
}
