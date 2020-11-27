//
//  SubscribeOrderCell.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/27.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class SubscribeOrderCell: UITableViewCell {

    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var assetRate: UILabel!
    @IBOutlet weak var assetTime: UILabel!
    @IBOutlet weak var assetPrice: UILabel!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var progressContainer: UIView!
    @IBOutlet weak var numberView: UILabel!
    
    let bar = StripeProgressBar(frame: .zero)
    var assets: TAssets? {
        didSet {
            
            titleView.text = assets?.title
            assetRate.text = assets?.rate_show
            assetTime.text = assets?.time_show
            assetPrice.text = assets?.price
            
            if let date = assets?.date {
                endTime.text = "认购截止：\(date.timeIntervalToStr(dateFormat: "yyyy-MM-dd"))"
            }
         
            if let a = assets {
                numberView.text = "已购/剩余：\(a.sold!)/\(a.left)"
            }
            
            let progress = Float(assets?.sold ?? "0")!/Float(assets?.total ?? "0")!
            bar.progress = CGFloat(progress)
            
            if assets?.status == 1 {
                stateView.image = UIImage(named: "state_subscribe_using")
            }else if assets?.status == 2 {
                stateView.image = UIImage(named: "state_trade_successful")
                
            }else if assets?.status == 3 {
                stateView.image = UIImage(named: "state_trade_fail")
            }
            
        }
    }
    
     lazy var stateView: UIImageView = {
        let state = UIImageView(image: UIImage(named: "state_subscribe_reffer"))
        return state
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        progressContainer.backgroundColor = .white
        
        self.selectionStyle = .none
        contentView.addSubview(stateView)
        stateView.snp.makeConstraints { (make) in
            make.right.top.equalTo(contentView)
        }
//        addHightlightsView()
        
        
        progressContainer.addSubview(bar)
        bar.snp.makeConstraints { (make) in
            make.edges.equalTo(progressContainer)
        }
        bar.progress = 0.0
        
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

