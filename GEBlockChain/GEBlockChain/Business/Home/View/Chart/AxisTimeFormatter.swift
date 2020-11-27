//
//  AxisTimeFormatter.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/23.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import Charts

class AxisTimeFormatter: NSObject, IAxisValueFormatter {

    private let dateFormatter = DateFormatter()
    var valueIntervals: [String] = []
    var type: Int = 0
    
    override init() {
        super.init()
        dateFormatter.dateFormat = "yyyy/MM"
    }
    
    func valueObIndex(index: Int) -> String {
        
        guard let timestamp = TimeInterval(valueIntervals[index]) else {
            return ""
        }
        return timestampToString(timestamp: timestamp)
    }
    
    private func timestampToString(timestamp: TimeInterval) -> String {
        let date = NSDate(timeIntervalSince1970: timestamp/1000)
        let formatter = DateFormatter.init()
        if type == 0 {
            formatter.dateFormat = "MM/dd"
        }else if type == 1 {
            formatter.dateFormat = "yyyy/MM"
        }else if type == 2 {
            formatter.dateFormat = "yyyy"
        }
        
        return formatter.string(from: date as Date)
    }
    
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        guard let timestamp = TimeInterval(valueIntervals[Int(value)]) else {
            return ""
        }
        return timestampToString(timestamp: timestamp)
    }
}
