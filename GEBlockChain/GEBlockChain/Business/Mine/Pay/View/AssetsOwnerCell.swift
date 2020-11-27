//
//  AssetsOwnerCell.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/20.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class AssetsOwnerCell: UITableViewCell {

    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var earnView: UILabel!
    @IBOutlet weak var avageView: UILabel!
    @IBOutlet weak var endTimeView: UILabel!
    @IBOutlet weak var incomeView: UILabel!
    @IBOutlet weak var numberView: UILabel!
    @IBOutlet weak var sellView: UILabel!
    @IBOutlet weak var stateView: UILabel!
    
    lazy var ownerAssets: OwnerAssets? = nil {
        didSet {
            if ownerAssets != nil {
                titleView.text = ownerAssets?.title
                earnView.text = ownerAssets?.rate
                endTimeView.text = ownerAssets?.date.timeIntervalToStr(dateFormat: "yyyy-mm-dd")
                incomeView.text = ownerAssets?.profit
                numberView.text = "资产总数：\(ownerAssets?.totle ?? "")"
                sellView.text = "在售资产：\(ownerAssets?.selling ?? "")"
                stateView.text = ownerAssets?.status_show
                if ownerAssets?.status == 1 {
                    stateView.layer.borderWidth = 1
                    stateView.layer.borderColor = "#35CC00".colorful().cgColor
                    stateView.textColor = "#35CC00".colorful()
                    stateView.backgroundColor = .white
                }else {
                    stateView.layer.borderWidth = 0
                    stateView.backgroundColor = "#F2F2F2".colorful()
                    stateView.textColor = "#C4C4C4".colorful()
                }
            }
           
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
