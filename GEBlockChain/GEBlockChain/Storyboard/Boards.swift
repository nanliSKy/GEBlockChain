//
//  Boards.swift
//  GEBlockChain
//
//  Created by nanli on 2020/7/22.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

internal enum Boards: String {
    
    case Main
    case Login
     
    var board: UIStoryboard {
        return Board(self)
    }
}

/// 生成故事版
///
/// - Parameter name: 故事板名称
/// - Returns: 故事版
func Board(_ board: Boards) -> UIStoryboard {
    return UIStoryboard(name: board.rawValue, bundle: nil)
}

/// 生成故事版内指定控制器
///
/// - Parameters:
///   - board: 故事版
///   - vc: 控制器
/// - Returns: 指定的控制器
func Board(_ board: Boards, _ vc: UIViewController.Type) -> UIViewController {
    return Board(board).destination(vc)
}


extension UIStoryboard {
    
    /// 指定的控制器
    ///
    /// - Parameter vc: 指定的控制器
    /// - Returns: 指定的控制器
    func destination(_ vc: UIViewController.Type) -> UIViewController {
        return self.instantiateViewController(withIdentifier: String(describing: vc))
    }
    
}
