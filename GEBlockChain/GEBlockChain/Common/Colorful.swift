//
//  Colorful.swift
//  GEBlockChain
//
//  Created by nanli on 2020/7/22.
//  Copyright © 2020 darchain. All rights reserved.
//

import Foundation

import UIKit

let Pen = Colorful()

final class Colorful {
    
    fileprivate init() { }
    
    let theme_primary = "#0882FE".colorful()
    
    
    subscript(_ colorful: ColorDisplay) -> UIColor? {
        return colorful.colorful
    }
    
    enum View: Int, ColorDisplay {
        case basement = 0, primary, secondary, thirddary, backColor, viewBackgroundColor, tableBackgroundColor
        
        var colorful: UIColor? {
            switch self {
            case .basement: return "#0882FE".colorful()
            case .primary: return "#181C24".colorful()
            case .secondary: return "#181C24".colorful()
            case .thirddary: return "#22252E".colorful()
            case .backColor: return UIColor.init(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1)
            case .viewBackgroundColor: return "#FBFCFE".colorful()
            case .tableBackgroundColor: return "#F3F7FC".colorful()
            }
        }
    }

    enum Label: Int, ColorDisplay {
        case primary = 0, secondary, red, blue, yellow
        
        var colorful: UIColor? {
            switch self {
            case .primary: return "#1F1F1F".colorful()
            case .secondary: return "#7A7A7A".colorful()
            case .red: return "#F71B1B".colorful()
            case .blue: return "#6FA8E3".colorful()
            case .yellow: return "#F7961B".colorful()
            }
            
        }
    }
    
    enum Line: Int, ColorDisplay {
        case primary
        var colorful: UIColor? {
            switch self {
            case .primary: return "22252E".colorful()
            }
        }
    }
    
    enum TFtext: Int, ColorDisplay {
        case placeHoler, contentColor, borderColor
        var colorful: UIColor? {
            switch self {
            case .placeHoler: return Pen.theme_primary
            case .contentColor: return Pen.label(.primary)
            case .borderColor: return Pen.view(.thirddary)
            }
        }
    }
}

extension Colorful {
        func view(_ view: Colorful.View) -> UIColor {
            return self[view] ?? .black
        }
        
        func label(_ label: Colorful.Label) -> UIColor {
            return self[label] ?? .white
        }
        
        func label(forBtn state: UIButton.State) -> UIColor {
            
            switch state {
            case .normal: return Pen.label(.primary)
            default: return Pen.label(.primary)
            }
        }
        
        func textfield(_ textfield: Colorful.TFtext) -> UIColor {
            return self[textfield] ?? . white
        }
}

protocol ColorDisplay {
    var colorful: UIColor? { get }
}
