//
//  IQStrings.swift
//  GEBlockChain
//
//  Created by nanli on 2020/7/22.
//  Copyright © 2020 darchain. All rights reserved.
//

import Foundation
import UIKit
import CommonCrypto

extension String {
    
    
    public func colorful() -> UIColor {
        
        let hexString = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
         
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
         
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
         
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
         
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
         
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
        
        
    }
}

extension String {
    
    func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strlen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestlen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(str!, strlen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestlen {
            hash.appendFormat("%02x", result[i])
        }
        
        free(result)
        return String(format: hash as String, arguments: [])
    }
}


extension TimeInterval {
    func timeIntervalToStr( dateFormat: String?) ->String {
        let date:NSDate = NSDate.init(timeIntervalSince1970: self/1000)
        let formatter = DateFormatter.init()
        if dateFormat == nil {
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }else {
            formatter.dateFormat = dateFormat
        }
        return formatter.string(from: date as Date)
    }
}
