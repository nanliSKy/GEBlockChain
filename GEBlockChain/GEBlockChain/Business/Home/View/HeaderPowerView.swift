//
//  HeaderPowerView.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/16.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import ReactiveSwift
class HeaderPowerView: XibView {
        
}

class IntroHeaderView: XibView {
    
    @IBOutlet weak var roundBackView: UIView!
    
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var rateView: UILabel!
    
    @IBOutlet weak var actionContainerView: UIView!
    @IBOutlet weak var numberView: UILabel!
    @IBOutlet weak var priceView: UILabel!
    @IBOutlet weak var timeView: UILabel!
    @IBOutlet weak var chartTitleView: UILabel!
    @IBOutlet weak var yValue: UILabel!
    @IBOutlet weak var chartContainerView: UIView!
    @IBOutlet weak var chartCheckView: UIView!
    @IBOutlet weak var bottomTitleView: UILabel!
    
    let chartOperator = MutableProperty((0, 0))
    var chartType = ChartType.rateC {
        didSet {
            chartView.chartType = chartType
        }
    }
    
    private let chartView: IntroLineChartView = IntroLineChartView(frame: .zero)
    private let barChart: IntroBarChartView = IntroBarChartView(frame: .zero)
    
    var charts:[YearProfit]? {
        didSet {
            chartView.charts = charts
            chartContainerView.addSubview(chartView)
        }
    }
    @IBOutlet weak var segmentedControl: MASegmentedControl! {
        didSet {
            segmentedControl.itemsWithText = true
            segmentedControl.fillEqually = true
            segmentedControl.bottomLineThumbView = true
            let strings = ["年化回报率", "发电量走势", "单份投资回报"]
            segmentedControl.setSegmentedWith(items: strings)
            segmentedControl.padding = 5
            
            segmentedControl.textColor = "#7A8FAC".colorful()
            segmentedControl.selectedTextColor = Pen.view(.basement)
            segmentedControl.thumbViewColor = Pen.view(.basement)
            segmentedControl.addTarget(self, action: #selector(segmemtedControlCC(_:)), for: .valueChanged)
        }
    }
    
    
    @IBOutlet weak var segmentedControlCheck: MASegmentedControl! {
        didSet {
            
            segmentedControlCheck.itemsWithText = true
            segmentedControlCheck.fillEqually = true
            segmentedControlCheck.roundedControl = true
            let strings = ["日", "月", "年"]
            segmentedControlCheck.setSegmentedWith(items: strings)
            segmentedControlCheck.padding = 5
            segmentedControlCheck.textColor = "#7A8FAC".colorful()
            segmentedControlCheck.selectedTextColor = .white
            segmentedControlCheck.thumbViewColor = Pen.view(.basement)
            segmentedControlCheck.addTarget(self, action: #selector(segmemtedControlCheckCC(_:)), for: .valueChanged)
        }
    }
    
    var assets: TAssets? {
        didSet {
            titleView.text = assets?.title
            rateView.text = assets?.rate_show
            timeView.text = assets?.time_show
            priceView.text = "单价：\(assets?.price ?? "0")元/份"
            numberView.text = "总数：\(assets?.total ?? "0")份"
            
        }
    }
    
    
    override func loadedFromNib() {
        super.loadedFromNib()

        chartView.chartValue.signal.observeValues { [unowned self] (x, y) in
            self.chartTitleView.text = "预计年化发电回报率（\(x)%）"
            self.yValue.text = "第\(Int(y))年"
        }
        
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if chartView.superview != nil {
            chartView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
        if barChart.superview != nil {
            barChart.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
        
        
    }
    
    
   @objc private func segmemtedControlCC(_ segmented: MASegmentedControl) {
        
        bottomTitleView.isHidden = !(segmented.selectedSegmentIndex == 0)
        segmentedControlCheck.isHidden = segmented.selectedSegmentIndex == 0
        segmentedControlCheck.selectedSegmentIndex = 0
    
        chartOperator.value = (segmentedControl.selectedSegmentIndex, segmentedControlCheck.selectedSegmentIndex)
    }
    
    @objc private func segmemtedControlCheckCC(_ segmented: MASegmentedControl) {
     
        chartOperator.value = (segmentedControl.selectedSegmentIndex, segmentedControlCheck.selectedSegmentIndex)
//         if segmented.selectedSegmentIndex == 0{
//            chartOperator.value = (0, 0)
//         }else if segmented.selectedSegmentIndex == 1 {
//            chartOperator.value = (0, 1)
//         }else if segmented.selectedSegmentIndex == 2 {
//
//         }
        
     }
    
    
    
}
