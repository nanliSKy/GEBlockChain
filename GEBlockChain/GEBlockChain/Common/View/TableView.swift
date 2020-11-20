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



protocol Reusable: class {
    static var identifier: String {get}
}

extension Reusable {
    static var identifier: String {
        return String(describing: self)
    }
}
extension UITableViewCell : Reusable{}
extension UICollectionViewCell : Reusable{}

extension UITableView {
    
    
    /// register Cell
    /// - Parameter : Cell Type
    func register<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.identifier)
    }
    
    
    /// get Cell
    /// - Parameter indexPath: IndexPath
    /// - Returns: Return Cell
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T {
            return cell
        }
        else {
            fatalError("The dequeueReusableCell (String(describing: T.self)) couldn't be loaded.")
        }
    }
}

extension UICollectionView {
    
    
    /// register Cell
    /// - Parameter : Cell Type
    func register<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.identifier)
    }
    
    
    /// get Cell
    /// - Parameter indexPath: IndexPath
    /// - Returns: Return Cell
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
       
        if let cell =  dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T {
            return cell
        }
        else {
            fatalError("The dequeueReusableCell (String(describing: T.self)) couldn't be loaded.")
        }
    }
}
