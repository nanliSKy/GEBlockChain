//
//  PlaceAnOrder.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/20.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import ReactiveSwift

class PlaceAnOrder: UIView {
    
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var rateView: UILabel!
    @IBOutlet weak var timeView: UILabel!
    @IBOutlet weak var priceView: UILabel!
    @IBOutlet weak var useView: UILabel!
    @IBOutlet weak var allNumberView: UILabel!
    @IBOutlet weak var leftView: UILabel!
    @IBOutlet weak var numView: UILabel!
    @IBOutlet weak var subNumberActionView: UIButton!
    @IBOutlet weak var addNumberActionView: UIButton!
    @IBOutlet weak var progressContainer: UIView!

    
    /// 购买数量
    let number = MutableProperty(1)
    let bar = StripeProgressBar(frame: .zero)
    var assets: TAssets? {
        didSet {
            
            titleView.text = assets?.title
            rateView.text = assets?.rate_show
            timeView.text = assets?.time_show
            priceView.text = assets?.price
            useView.text = "已购：\(assets?.sold ?? "0")"
            allNumberView.text = "总块数：\(assets?.total ?? "0")"
            leftView.text = "剩余：\(assets?.left ?? "0")"
            
            let progress = Float(assets?.sold ?? "0")!/Float(assets?.total ?? "0")!
            bar.progress = CGFloat(progress)
            
        }
    }
    var buyNumber: NSInteger = 1 {
        didSet {
            numView.text = "\(buyNumber)"
        }
    }
    
    private func numberControl() {
        subNumberActionView.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] (_) in
            if self.buyNumber > 1 {
                self.buyNumber -= 1
            }
            self.number.value = self.buyNumber
        }
        
        addNumberActionView.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] (_) in
            if let left = NSInteger(assets?.left ?? "0") {
                if self.buyNumber < left {
                    self.buyNumber += 1
                }
            }
            
            self.number.value = self.buyNumber
        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        progressContainer.backgroundColor = .white
        
       
//        addHightlightsView()
        
        
        progressContainer.addSubview(bar)
        bar.snp.makeConstraints { (make) in
            make.edges.equalTo(progressContainer)
        }
        bar.progress = 0.0
        
        numberControl()
        
    }
}
