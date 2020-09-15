//
//  AssetSectionView.swift
//  GEBlockChain
//
//  Created by nan li on 2020/7/30.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class AssetSectionView: UIView {

    let content: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 16)
        l.textColor = Pen.label(.secondary)
        l.text = "新品上线".localized
        return l
    }()
    
    let mark: UIImageView = {
        let img = UIImageView(image: UIImage(named: "home_project_new"))
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createBindView()

    }
    
    func createBindView() {
        addSubview(content)
        addSubview(mark)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        content.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(self.snp.left).offset(25)
        }
        mark.snp.makeConstraints { (make) in
            make.centerY.equalTo(content.snp.centerY)
            make.left.equalTo(content.snp.right).offset(12)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
