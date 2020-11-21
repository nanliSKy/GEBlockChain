//
//  IQProgressBar.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/13.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

@IBDesignable open class IQProgressBar: UIView {
    
    private weak var progress : UIView!
        
        //MARK: - INSPECTABLE VARIABLES
        @IBInspectable open var roundedCorners : Bool = true {
            didSet {
                self.updateUI()
            }
        }
        
        @IBInspectable open var spacing : CGFloat = 2 {
            didSet {
                self.spacing = max(0, spacing)
                self.updateUI()
            }
        }
        
        @IBInspectable open var outlineWidth : CGFloat = 2 {
            didSet {
                self.outlineWidth = max(0, outlineWidth)
                self.updateUI()
            }
        }
        
        @IBInspectable open var outlineColor : UIColor = .white {
            didSet {
                self.updateUI()
            }
        }
        
        @IBInspectable open var progressColor : UIColor = .white {
            didSet {
                self.updateUI()
            }
        }
        
        /**
         Sets the value of the progress bar in a range of 0.0 to 1.0.
         */
        @IBInspectable open var value : CGFloat = 0 {
            didSet {
                self.value = max(0, min(value, 1))
                self.updateUI()
            }
        }
        
        //MARK: - INITIALIZERS
        init() {
            fatalError("Should call init(frame:) or init(coder:)")
        }
        
        override public init(frame: CGRect) {
            super.init(frame: frame)
            self.commonInit()
        }
        
        required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            self.commonInit()
        }
        
        //
        open override func layoutSubviews() {
            super.layoutSubviews()
            self.updateUI()
        }
        
        internal func commonInit() {
            self.addProgress()
            self.updateUI()
        }
        
        private func addProgress() {
            let progress = UIView()
            progress.translatesAutoresizingMaskIntoConstraints = false
            progress.backgroundColor = self.progressColor
            self.addSubview(progress)
            self.progress = progress
        }
        
        private var progressConstraints = [NSLayoutConstraint]()
        
        private func updateUI() {
            self.removeConstraints(self.progressConstraints)
            self.progressConstraints = [
                self.progress.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.outlineWidth + self.spacing),
                self.progress.widthAnchor.constraint(greaterThanOrEqualTo: self.widthAnchor, multiplier: self.value, constant: -(self.outlineWidth * 2 + self.spacing * 2)),
                self.progress.topAnchor.constraint(equalTo: self.topAnchor, constant: self.outlineWidth + self.spacing),
                self.progress.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -(self.outlineWidth + self.spacing))
            ]
            NSLayoutConstraint.activate(progressConstraints)
            
            self.layer.cornerRadius = self.roundedCorners ? self.frame.height / 2 : 0
            self.progress.layer.cornerRadius = self.roundedCorners ? self.progress.frame.height / 2 : 0
            self.progress.backgroundColor = self.progressColor
            self.layer.borderWidth = self.outlineWidth
            self.layer.borderColor = self.outlineColor.cgColor
        }
}


class StripeProgressBar: UIView {
    
    var stripesWidth: CGFloat = 5
    var stripesOffset: CGFloat = 5
    var stripesAngle: CGFloat = 45
    var progress: CGFloat = 0.0 {
        didSet {
            setMaskLayer()
        }
    }
    
    
    private let backgroundLayer: CAShapeLayer = CAShapeLayer()
    private let forgroundLayer: CAShapeLayer = CAShapeLayer()
    private let progressMaskLayer: CAShapeLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(forgroundLayer)
        
        backgroundLayer.lineWidth = 0
        backgroundLayer.fillColor = "#D8E4F0".colorful().cgColor
    
        forgroundLayer.lineWidth = 0
        forgroundLayer.fillColor = "#0882FE".colorful().cgColor
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setMaskLayer() {
        let path = UIBezierPath()
        let rate = (width + 3*height/4) * progress
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x:-height/2, y: height))
        path.addLine(to: CGPoint(x: -height/2 + rate, y: height))
        path.addLine(to: CGPoint(x: rate, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        progressMaskLayer.lineWidth = bounds.height
        progressMaskLayer.path = path.cgPath
//        progressMaskLayer.strokeEnd = progress
        progressMaskLayer.backgroundColor = UIColor.gray.cgColor
        forgroundLayer.mask = progressMaskLayer
    }
    
    private func drawStripeProgressView() {
        
        let path = UIBezierPath()
        let height = bounds.height
        let radius: CGFloat = height/2
        
        //先画半圆
        path.addArc(withCenter: CGPoint(x: radius, y: radius), radius: radius, startAngle: .pi/2, endAngle: .pi/2*3, clockwise: true)
        
        stripesAngle = 45
        let count = Int((bounds.width - height)/(stripesWidth + stripesOffset))
//        let xOffset = height/tan(stripesAngle/180 * .pi)
    
        let xOffset: CGFloat = 10.0
        
        let point = CGPoint(x: radius, y: 0)
        
        for i in 0 ... count {
            if i == 0 {
                path.move(to: point)
                path.addLine(to: CGPoint(x: radius + xOffset, y: 0))
                path.addLine(to: CGPoint(x: radius, y: height))
                path.addLine(to: point)
            }else {
                let index: CGFloat = CGFloat(i)
                path.move(to: CGPoint(x: radius + xOffset + index * stripesOffset + (index - 1)*stripesWidth, y: 0))
                path.addLine(to: CGPoint(x: radius + xOffset + index * (stripesWidth + stripesOffset), y: 0))
                path.addLine(to: CGPoint(x: radius + index * (stripesWidth + stripesOffset), y: height))
                path.addLine(to: CGPoint(x:radius + index * stripesOffset + (index - 1)*stripesWidth, y: height))
                path.addLine(to: CGPoint(x:radius + xOffset + index * stripesOffset + (index - 1)*stripesWidth, y: 0))
                
            }
        }
        
        let left = bounds.width - height - (stripesWidth + stripesOffset) * CGFloat(count) - xOffset
        if left > 0 {
            let point = CGPoint(x: bounds.width - left, y: 0)
            path.move(to: point)
            path.addLine(to: CGPoint(x: bounds.width - height/2, y: 0))
            path.addLine(to: CGPoint(x: bounds.width - height/2, y: height))
            path.addLine(to: CGPoint(x: bounds.width - radius - (stripesWidth + stripesOffset) * CGFloat(count), y: height))
            path.addLine(to: point)
        }
        path.addArc(withCenter: CGPoint(x: bounds.width - radius, y: radius), radius: radius, startAngle: .pi/2*3, endAngle: .pi/2, clockwise: true)

        backgroundLayer.path = path.cgPath
        forgroundLayer.path = path.cgPath
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    
        layer.masksToBounds = true
        backgroundLayer.frame = bounds
        forgroundLayer.frame = bounds
        stripesWidth = height/2
        stripesOffset = height/2
        
        setMaskLayer()
        drawStripeProgressView()
    }

}
