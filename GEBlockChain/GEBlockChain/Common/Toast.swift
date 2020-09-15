//
//  Toast.swift
//  GEBlockChain
//
//  Created by nan li on 2020/7/29.
//  Copyright © 2020 darchain. All rights reserved.
//

import PKHUD

import UIKit

import ReactiveSwift

final class Toast {
    
    static let `default` = Toast()
    
    private init() {
        PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = true
    }
    
    static func show(message: String?) {
        Toast.default.show(message)
    }
    
    func show(_ message: String?, _ delay: TimeInterval = 2) {
        if let msg = message {
            HUD.flash(.label(msg), delay: delay)
        }
        return
    }
}

extension Toast {
    static func show<T>(_ signal: T) where T: SignalProtocol, T.Value: CustomStringConvertible, T.Error == Never {
        Toast.default.reactive.show <~ signal.signal.map { $0.description }
    }
}

extension Toast: ReactiveExtensionsProvider { }

extension Reactive where Base == Toast {
    
    var show: BindingTarget<String?> {
        return makeBindingTarget { $0.show($1) }
    }
    
    var netmare: BindingTarget<NetError> {
        return makeBindingTarget { $0.show($1.description) }
    }
    
}
