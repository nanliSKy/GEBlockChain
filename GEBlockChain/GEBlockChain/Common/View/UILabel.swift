//
//  UILabel.swift
//  GEBlockChain
//
//  Created by nan li on 2020/8/20.
//  Copyright © 2020 darchain. All rights reserved.
//

extension UILabel {
    
}

class UILabelPadding: UILabel {
    
    var padding  = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect)
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insets = self.padding
        var rect = super.textRect(forBounds: bounds.inset(by: insets), limitedToNumberOfLines: numberOfLines)
        rect.origin.x    -= insets.left
        rect.origin.y    -= insets.top
        rect.size.width  += (insets.left + insets.right)
        rect.size.height += (insets.top + insets.bottom)
        return rect
    }
    
}
