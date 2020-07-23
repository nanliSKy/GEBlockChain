//
//  ViewController.swift
//  GEBlockChain
//
//  Created by nanli on 2020/7/17.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var counter = Count()
        counter.dataSource = ThreeSource()
        for _ in 1...4 {
            counter.increment()
            print(counter.count)
        }
        
       
    }
    
    

}



//MARK:如果协议中用可选的满足实现，需要声明@objc

@objc protocol CountDataSource {
   @objc optional func increment(forCount count: Int) -> Int
    var fixedIncrement: Int { get }
}


class Count {
    var count = 0
    var dataSource: CountDataSource?
    func increment()  {
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        }else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

class ThreeSource: NSObject, CountDataSource {
  
    
    let fixedIncrement = 3
    
}
