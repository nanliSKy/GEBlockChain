//
//  GEMarketViewController.swift
//  GEBlockChain
//
//  Created by nanli on 2020/7/22.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class GEMarketViewController: GEBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        let progress = IQProgressBar.init(frame: .zero)
        progress.value = 0.6
        progress.progressColor = .red
        progress.backgroundColor = .green
        progress.spacing = 2
        progress.outlineWidth = 1
        view.addSubview(progress)
        progress.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(90)
            make.width.equalTo(300)
            make.height.equalTo(20)
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
