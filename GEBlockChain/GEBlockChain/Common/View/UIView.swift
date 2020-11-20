//
//  UIView.swift
//  GEBlockChain
//
//  Created by nan li on 2020/7/24.
//  Copyright © 2020 darchain. All rights reserved.
//



/// View 添加阴影
protocol shadowColor {
    
    func vshadowColor(radius rdaius: CGFloat, opacity opactiy: Float, s size: CGSize, c color: UIColor)
}

extension UIView: shadowColor {

     func vshadowColor(radius rdaius: CGFloat, opacity opactiy: Float, s size: CGSize, c color: UIColor) {
        layer.cornerRadius = rdaius
        layer.shadowOpacity = opactiy
        layer.shadowOffset = size
        layer.shadowColor = color.cgColor
    }
    
    func addTransitionColor(sc startColor: UIColor, ec endColor: UIColor, sp startPoint: CGPoint, ep endPoint: CGPoint) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.layer.cornerRadius
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
}

extension UIView {
    
    
    private struct AssociatedKey {
        static var KCornerRadius: String = "KCornerRadius"
        static var KBorderWidth: String = "KBorderWidth"
        static var KBorderColor: String = "KBorderColor"
    }
    
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.KCornerRadius) as! CGFloat
        }
                
        set {
        
            objc_setAssociatedObject(self, &AssociatedKey.KCornerRadius, newValue, .OBJC_ASSOCIATION_ASSIGN)
            layer.cornerRadius = newValue
            layer.masksToBounds = (newValue>0)
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.KBorderWidth) as! CGFloat
        }
                
        set {
        
            objc_setAssociatedObject(self, &AssociatedKey.KBorderWidth, newValue, .OBJC_ASSOCIATION_ASSIGN)
            layer.borderWidth = newValue
        }
    }

    @IBInspectable public var borderColor: UIColor {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.KBorderColor) as! UIColor
        }
                
        set {
        
            objc_setAssociatedObject(self, &AssociatedKey.KBorderWidth, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            layer.borderColor = newValue.cgColor
        }
    }

}
