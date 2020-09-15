//
//  TableView.swift
//  GEBlockChain
//
//  Created by nan li on 2020/7/30.
//  Copyright © 2020 darchain. All rights reserved.
//

extension UIView {
    static func className() -> String {
        return String(describing: self)
    }
    
    static func getNib(_ bundle: Bundle? = nil) -> UINib? {
        return UINib(nibName: className(), bundle: bundle)
    }
}

extension UITableView {
    func register(cell: UITableViewCell.Type, _bundle:Bundle? = nil) {
        self.register(cell, forCellReuseIdentifier: cell.className())
    }
}



