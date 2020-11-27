//
//  IndexFooterView.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/26.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import ReactiveSwift

class IndexFooterView: XibView {

    @IBOutlet weak var leftAmount: UILabel!
    @IBOutlet weak var leftOperator: UIButton!
    @IBOutlet weak var rightOperator: UIButton!
    
    var uoperator = MutableProperty(0)
    
    var status: Int = -1 {
        didSet {
            updateOperatorView()
        }
    }
    override func loadedFromNib() {
        super.loadedFromNib()
        backgroundColor = .white
        updateOperatorView()
        bindOPerator()
    }
    
    //01立即购买  10000:2出售订单3取消出售。4出售换钱
    private func updateOperatorView() {
        if status == 0 || status == 1{
            leftOperator.isHidden = true
            rightOperator.setTitle("立即够买", for: .normal)
        }else if status == 10000 {
            leftOperator.isHidden = true
            rightOperator.setTitle("取消出售", for: .normal)
        }else if status == 10001 {
            leftOperator.isHidden = true
            rightOperator.setTitle("出售换钱", for: .normal)
        }
    }
    
    private func bindOPerator() {
        
        leftOperator.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] (sender) in
            self.uoperator.value = 1 //出售
        }
        
        rightOperator.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] (sender) in
            if self.status == 0 || self.status == 1 {
                self.uoperator.value = self.status
            }else if self.status == 10000 {
                self.uoperator.value = 3
            }else if self.status == 10001 {
                self.uoperator.value = 4
            }
            
        }
    }
}
