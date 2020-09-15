//
//  BannerView.swift
//  GEBlockChain
//
//  Created by nan li on 2020/7/29.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import SnapKit

class BannerView<V: UIView>: UIView, UIScrollViewDelegate {
    
    enum Direction {
        case horizontal, vertical
    }
    
    private(set) var direction: Direction = .horizontal
    
    private var previousView: UIView?
    private var currentView: UIView?
    private var nextView: UIView?
    
    private lazy var scrollView: UIScrollView = {
        let s = UIScrollView()
        s.bounces = true
        s.isPagingEnabled = true
        s.showsHorizontalScrollIndicator = false
        s.showsVerticalScrollIndicator = false
        s.delegate = self
        if #available(iOS 11.0, *) {
            s.contentInsetAdjustmentBehavior = .never
        }
        self.addSubview(s)
        s.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        return s
    }()

    private lazy var pageControl: UIPageControl = {
        let p = UIPageControl()
        p.isUserInteractionEnabled = false
        self.addSubview(p)
        p.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(10)
        }
        return p
    }()
    
    private(set) var isScrolling: Bool = false
    private(set) var index: Int = 0
    private(set) var count: Int = 0
    
    private var fillContent: ((V, Int) -> ())?
    
    var tap: ((Int) -> ())?
    
    var interval: TimeInterval = 4.0
    
    var scrollEnabled: Bool = true {
        didSet{
            scrollView.isScrollEnabled = self.scrollEnabled
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(goDetail))
        self.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(direction: Direction, item: () -> V, content: @escaping (V, Int) -> (), count: Int) {
        
        self.direction = direction
        self.index = 0
        self.count = count
        self.fillContent = content
        
        stopScroll()
        
        for subView in scrollView.subviews {
            subView.removeFromSuperview()
        }
        
        switch count {
        case 1:
            currentView = createItemView(0, item)
            pageControl.isHidden = true
        default:
            previousView = createItemView(0, item)
            currentView = createItemView(1, item)
            nextView = createItemView(2, item)
            
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                switch self.direction {
                case .vertical:
                    self.scrollView.setContentOffset(CGPoint(x: 0, y: self.frame.size.height), animated: false)
                case .horizontal:
                    self.scrollView.setContentOffset(CGPoint(x: self.frame.size.width, y: 0), animated: false)
                }
            }
            
            pageControl.isHidden = direction == .vertical
            pageControl.numberOfPages = count
            
            startScroll()
        }

        resetAllItemContent()
    }
    
    private func createItemView(_ page: Int, _ item: () -> V) -> UIView {
        
        let v = item()
        scrollView.addSubview(v)
        
        var left: CGFloat = 0
        var right: CGFloat = 0
        var top: CGFloat = 0
        var bottom: CGFloat = 0
        
        if count > 1 {
            switch direction {
            case .vertical:
                top = frame.size.height * CGFloat(page)
                bottom = frame.size.height * CGFloat(2 - page)
            case .horizontal:
                left = frame.size.width * CGFloat(page)
                right = frame.size.width * CGFloat(2 - page)
            }
        }
        
        v.snp.makeConstraints { (make) in
            make.top.equalTo(top)
            make.bottom.equalTo(-bottom)
            make.left.equalTo(left)
            make.right.equalTo(-right)
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }

        return v
    }
    
    func startScroll() {
        
        if isScrolling || count <= 1 {
            return
        }
        isScrolling = true
        perform(#selector(delayScrollToNext), with: nil, afterDelay: interval, inModes: [.common])
        
    }
    
    func stopScroll() {
        
        isScrolling = false
        NSObject.cancelPreviousPerformRequests(withTarget: self)
    }
    
    @objc private func delayScrollToNext() {
        perform(#selector(delayScrollToNext), with: nil, afterDelay: interval, inModes: [.common])
        
        if window == nil {
            return
        }
        
        switch direction {
        case .vertical:
            self.scrollView.setContentOffset(CGPoint(x: 0, y: frame.size.height * 2), animated: true)
        case .horizontal:
            self.scrollView.setContentOffset(CGPoint(x: frame.size.width * 2, y: 0), animated: true)
        }
        
    }
    
    
    private func resetItemViews() {
        
        let back = scrollView.contentOffset.x < frame.size.width && direction == .horizontal || scrollView.contentOffset.y < frame.size.height && direction == .vertical
        let forward = scrollView.contentOffset.x > frame.size.width && direction == .horizontal || scrollView.contentOffset.y > frame.size.height && direction == .vertical
        
        if back {
            switch index {
            case 0: index = count - 1
            default: index -= 1
            }
        }else if forward {
            switch index {
            case count - 1: index = 0
            default: index += 1
            }
        }
        
        resetAllItemContent()
        
        if direction == .vertical {
            scrollView.setContentOffset(CGPoint(x: 0, y: frame.size.height), animated: false)
        }else{
            scrollView.setContentOffset(CGPoint(x: frame.size.width, y: 0), animated: false)
        }
        
        pageControl.currentPage = index
    }
    
    private func resetAllItemContent() {
        
        guard let f = fillContent else { return }
        
        if let c = currentView as? V{
            f(c, index)
        }
        
        if count < 2 { return }

        if let p = previousView as? V {
            
            switch index {
            case 0: f(p, count - 1)
            default: f(p, index - 1)
            }
        }
        
        if let n = nextView as? V {
            
            switch index {
            case count - 1: f(n, 0)
            default: f(n, index + 1)
            }
        }
        
    }
    
    
    @objc private func goDetail(){
        
        if let t = tap {
            t(index)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopScroll()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startScroll()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        resetItemViews()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        resetItemViews()
    }
    
}


