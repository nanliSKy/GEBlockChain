//
//  TradeOrderCell.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/20.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class TradeOrderCell: UITableViewCell {

    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var stateView: UILabel!
    @IBOutlet weak var rateView: UILabel!
    @IBOutlet weak var timeView: UILabel!
    @IBOutlet weak var priceView: UILabel!
    @IBOutlet weak var allPriceView: UILabel!
    @IBOutlet weak var actionView: UIView!
    @IBOutlet weak var payOrderAction: UIButton!
    @IBOutlet weak var cancelOrderAction: UIButton!
    
    var asset: TAssets? {
        didSet {
            titleView.text = asset?.title
            rateView.text = asset?.rate_show
            timeView.text = asset?.time_show
            priceView.text = asset?.price
            allPriceView.text = asset?.total
            
            switch asset?.status {
            case 1:
                stateView.text = "认购中"
                break
            case 2:
                stateView.text = "已成功"
                break
            case 3:
                stateView.text = "已失败"
                break
            default:
                stateView.text = "其他"
                break
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
