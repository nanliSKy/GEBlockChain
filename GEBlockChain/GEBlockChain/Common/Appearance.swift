//
//  Appearance.swift
//  GEBlockChain
//
//  Created by nanli on 2020/7/22.
//  Copyright © 2020 darchain. All rights reserved.
//

import Foundation

import UIKit

final class Appearance {
    
    static func appearance() {
        navigation()
    }
    
    private static func navigation() {
        UINavigationBar.appearance().barTintColor = UIColor.white
        UINavigationBar.appearance().tintColor = Pen.label(.primary)
//        UINavigationBar.appearance().isTranslucent = false
//
//        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : Pen.label(.primary)], for: .normal)
//
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : Pen.label(.primary)]
//
//        UILabel.appearance().textColor = Pen.label(.primary)
    }
}
