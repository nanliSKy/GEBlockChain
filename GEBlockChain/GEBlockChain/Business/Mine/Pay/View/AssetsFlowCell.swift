//
//  AssetsFlowCell.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/20.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class AssetsFlowCell: UITableViewCell {

    @IBOutlet weak var balanceView: UILabel!
    @IBOutlet weak var operatorView: UILabel!
    @IBOutlet weak var timeView: UILabel!
    @IBOutlet weak var numberView: UILabel!
    
    var flow: AssetsFlow? {
        didSet {
            operatorView.text = flow?.op
            balanceView.text = "余额：\(flow!.balance)"
            timeView.text = flow?.date.timeIntervalToStr(dateFormat: "yyyy-mm-dd")
            numberView.text = "\(flow!.symbol)\(flow!.amount)元"
            numberView.textColor = flow!.color.colorful()
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
