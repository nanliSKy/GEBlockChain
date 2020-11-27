//
//  IntroBarChartView.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/25.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import Charts

class IntroBarChartView: UIView {
    
    private let barChartView: BarChartView = {
        let chartView = BarChartView()
        chartView.setExtraOffsets(left: 0, top: 10, right: 0, bottom: 10)
        chartView.backgroundColor = .white
        chartView.borderLineWidth = 0.5
        chartView.noDataText = "无数据"
        chartView.chartDescription?.enabled = false
        chartView.scaleXEnabled = false
        chartView.scaleYEnabled = false
        chartView.pinchZoomEnabled = false
        chartView.doubleTapToZoomEnabled = false
        chartView.highlightPerTapEnabled = true
        chartView.autoScaleMinMaxEnabled = true
        chartView.legend.enabled = false
        chartView.animate(xAxisDuration: 0.5)
        
        chartView.rightAxis.enabled = false
        
        //设置坐标轴
        let leftAxis = chartView.leftAxis
        leftAxis.labelPosition = YAxis.LabelPosition.outsideChart
        leftAxis.drawGridLinesEnabled = false
        leftAxis.drawTopYLabelEntryEnabled = true
        leftAxis.decimals = 3
        leftAxis.gridColor = "#D6E0E7".colorful()
        leftAxis.axisLineColor = .clear
        leftAxis.labelFont = UIFont.systemFont(ofSize: 12)
        leftAxis.labelTextColor = "#D6E0E7".colorful()
        
        let bmxAxis = chartView.xAxis
        bmxAxis.labelPosition = XAxis.LabelPosition.bottom
        bmxAxis.drawGridLinesEnabled = false
        bmxAxis.labelFont = UIFont.systemFont(ofSize: 12)
        bmxAxis.labelTextColor = "#8E9091".colorful()
        bmxAxis.axisLineColor = .clear
        bmxAxis.labelCount = 20
        
//        bmxAxis.valueFormatter = AxisTimeFormatter()
        
        chartView.drawMarkers = true
        let markerView = MarkerView()
        markerView.chartView = chartView
        chartView.marker = markerView
        return chartView
    }()

}


extension IntroBarChartView: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
//        masker.text = NSString(format: "%.2f", arguments: entry.y) as? String
    }
}
