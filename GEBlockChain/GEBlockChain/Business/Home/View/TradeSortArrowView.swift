//
//  TradeSortArrowView.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/19.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import ReactiveSwift
class TradeSortArrowView: UIView {

    var select: Bool = false {
        didSet {
            self.titleView.textColor = select ? Pen.view(.basement) : "#B3B1B1".colorful()
            if select {
                self.iconView.image = UIImage(named: self.ascending ? "arrow_up" : "arrow_down")
            }else {
                self.iconView.image = UIImage(named: "up_down")
            }
            
        }
    }
    var ascending: Bool = true {
        didSet {
            self.iconView.image = UIImage(named: self.ascending ? "arrow_up" : "arrow_down")
        }
    }
    var index: Int = 0
    private(set) var state = MutableProperty((0, 0))  //0未选中 1选中向上 2选中向下
    
    let titleView: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.text = "收益排行"
        l.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return l
    }()
    
    let iconView: UIImageView = {
        let i = UIImageView()
        i.contentMode = UIView.ContentMode.scaleAspectFit
        i.image = UIImage(named: "up_down")
        return i
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        arrowViewCreate()

        let tap = UITapGestureRecognizer()
        tap.reactive.stateChanged.observeValues { [unowned self] _ in
            if self.select {
                self.ascending = !self.ascending
                self.state.value = self.ascending ? (self.index, 1)  : (self.index, 2)
            }else {
                self.select = !self.select
                self.ascending = true
                self.state.value = (self.index, 1)
            }
            
        }
        addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func arrowViewCreate() {
        let stack = UIStackView(arrangedSubviews: [titleView, iconView])
        stack.axis = .horizontal
        stack.spacing = 6
        addSubview(stack)
        stack.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

class TradeArrorContainer: UIView {
    
    let eranArror: TradeSortArrowView = {
        let arror = TradeSortArrowView(frame: .zero)
        arror.titleView.text = "收益排行"
        arror.titleView.textColor = "#B3B1B1".colorful()
        arror.index = 0
        return arror
    }()
    
    let priceArror: TradeSortArrowView = {
        let arror = TradeSortArrowView(frame: .zero)
        arror.titleView.text = "单价排行"
        arror.titleView.textColor = "#B3B1B1".colorful()
        arror.index = 1
        return arror
    }()
    
    let numberArror: TradeSortArrowView = {
        let arror = TradeSortArrowView(frame: .zero)
        arror.titleView.text = "数量排行"
        arror.titleView.textColor = "#B3B1B1".colorful()
        arror.index = 2
        return arror
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        tradeArrorCreate()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tradeArrorCreate() {
        let stack = UIStackView(arrangedSubviews: [eranArror, priceArror, numberArror])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        addSubview(stack)
        stack.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }

    }
    
    func mergeBind() -> Signal<(Int, Int), Never>? {
        
        return Signal.merge(eranArror.state.signal, priceArror.state.signal, numberArror.state.signal).map({ [unowned self] (index, up) -> (Int, Int) in
            if index == 0 {
                self.eranArror.select = true
                self.priceArror.select = false
                self.numberArror.select = false
            }else if index == 1 {
                self.eranArror.select = false
                self.priceArror.select = true
                self.numberArror.select = false
            }else if index == 2 {
                self.eranArror.select = false
                self.priceArror.select = false
                self.numberArror.select = true
            }
            return (index, up)
        })
    }
}
