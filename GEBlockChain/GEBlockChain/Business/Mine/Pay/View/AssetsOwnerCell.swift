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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
