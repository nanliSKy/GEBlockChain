//
//  IntroLineChartView.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/23.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import Charts
import ReactiveSwift
enum ChartType {
    case profitC  //单份投资回报
    case rateC  //年华回报率
    case powerC //发电走势
}

class CubicLineSampleFillFormatter: IFillFormatter {
    func getFillLinePosition(dataSet: ILineChartDataSet, dataProvider: LineChartDataProvider) -> CGFloat {
        return -10
    }
}
class IntroLineChartView: UIView {

    var charts: [YearProfit]? {
        didSet {
            setDataCount(charts!)
        }
    }
    
    var chartValue = MutableProperty((0.0, 0.0))
    var chartType = ChartType.rateC
    
    private let lineChartView: LineChartView = {
        let chartView = LineChartView()
        
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
        leftAxis.decimals = 3
        leftAxis.gridColor = "#D6E0E7".colorful()
        leftAxis.axisLineColor = .clear
        leftAxis.labelFont = UIFont.systemFont(ofSize: 12)
        leftAxis.labelTextColor = "#D6E0E7".colorful()
        leftAxis.drawGridLinesEnabled = false
        leftAxis.axisMinimum = -5
        
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
//        markerView.addSubview(self.masker)
        
        return chartView

    }()
    
    private let masker: UILabel = {
        let label = UILabel(frame: CGRect(x: -20, y: -30, width: 50, height: 22))
        label.layer.cornerRadius = 11
        label.clipsToBounds = true
        label.textAlignment = .center
        label.textColor = "#7A8FAC".colorful()
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview(lineChartView)
        lineChartView.delegate = self
        lineChartView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
//        updateChartData()
    }
    
 
    
//    func updateChartData() {
//        self.setDataCount(45, range: 100)
//    }
    
    func setDataCount(_ profits: [YearProfit]) {

        let yVals1 = (0..<profits.count).map { (i) -> ChartDataEntry in
            
            let profit = profits[i]
            return ChartDataEntry(x: Double(i + 1), y: profit.rY)
        }
          
        let set1 = LineChartDataSet(entries: yVals1, label: "DataSet 1")
        set1.mode = .horizontalBezier
        set1.drawCirclesEnabled = false
        set1.lineWidth = 0
        set1.circleRadius = 2
        set1.setCircleColor("#44AFFE".colorful())
        set1.cubicIntensity = 0.1  //弧度
        set1.highlightColor = "#44AFFE".colorful()
        set1.highlightLineDashLengths = [5, 5]
        set1.colors = ["#44AFFE".colorful()]
        set1.drawFilledEnabled = true
        set1.fillColor = "#44AFFE".colorful()
        set1.valueTextColor = .clear
        set1.drawHorizontalHighlightIndicatorEnabled = true
        
        
        let data = LineChartData(dataSet: set1)
        data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 9)!)
        data.setDrawValues(false)
        
        lineChartView.data = data
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}

extension IntroLineChartView: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        chartValue.value = (entry.y, entry.x)
//        masker.text = NSString(format: "%.2f", arguments: entry.y) as? String
    }
}
