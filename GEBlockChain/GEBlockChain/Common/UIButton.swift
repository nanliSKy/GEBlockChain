//
//  UIButton.swift
//  GEBlockChain
//
//  Created by nan li on 2020/7/24.
//  Copyright © 2020 darchain. All rights reserved.
//

extension UIButton {
    
    struct Key {
        static var timerKey = "timerKey"
    }
    
    
    var timer: DispatchSourceTimer? {
        get {
            return objc_getAssociatedObject(self, &Key.timerKey) as? DispatchSourceTimer
        }
        set {
            objc_setAssociatedObject(self, &Key.timerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    
    /// 开启定时
    /// - Parameters:
    ///   - duration: 倒计时时长
    ///   - disableBackgroundColor: 不可用状态背景色
    ///   - disableTitleColor: 不可用状态 Title 颜色
    func timerCountDuration(duration: Int, disableBackgroundColor: UIColor = .gray, disableTitleColor: UIColor = .white) {
        var times = duration
        let normalBackground = backgroundColor
        
        timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
        timer?.setEventHandler(handler: {
            if times > 0 {
                DispatchQueue.main.async {
                    self.isEnabled = false
                    self.setTitle("\(times)s", for: .disabled)
                    self.setTitleColor(disableTitleColor, for: .disabled)
                    self.backgroundColor = disableBackgroundColor
                    times -= 1
                }
            }else {
                DispatchQueue.main.async {
                    self.isEnabled = true
                    self.setTitleColor(disableTitleColor, for: .disabled)
                    self.backgroundColor = normalBackground
                    self.timer?.cancel()
                    self.timer = nil
                }
            }
        })
        
        timer?.schedule(deadline: .now(), repeating: .seconds(1), leeway: .milliseconds(100))
        timer?.resume()
    }
    
    
    /// 取消倒计时
    /// - Parameter backgroundColor: 背景色
    func cancel(backgroundColor: UIColor) {
        DispatchQueue.main.async {
            self.isEnabled = true
            self.backgroundColor = backgroundColor
            self.timer?.cancel()
            self.timer = nil
            
        }
    }
}
