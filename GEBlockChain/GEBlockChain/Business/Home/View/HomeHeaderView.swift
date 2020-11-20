//
//  HomeHeaderView.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/19.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class HomeHeaderView: UIView {

    @IBOutlet weak var invateFriend: UIView!
    @IBOutlet weak var guider: UIView!
    @IBOutlet weak var safe: UIView!
    @IBOutlet weak var moreAction: UIButton!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    

    
    override func awakeFromNib() {
        super.awakeFromNib()

        moreAction.set(image: UIImage(named: "home_info_indicator"), title: "更多".localized, titlePosition: .left,
                   additionalSpacing: 8, state: .normal)
        
        
    }

}
