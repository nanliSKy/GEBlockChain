//
//  OrderMenuCell.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/20.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class OrderMenuCell: UITableViewCell {

    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var recommendView: UILabel!
    @IBOutlet weak var menuView: UILabel!
    @IBOutlet weak var actionView: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
