//
//  AssetsIndexTableHeaderView.swift
//  GEBlockChain
//
//  Created by nan li on 2020/7/29.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class AssetsIndexTableHeaderView: UIView {
    
    var bannerView: BannerView<BannerItem>!

    let make: UILabel = {
        let l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 16)
        l.textColor = Pen.label(.primary)
        l.text = "新能源投资理财".localized
        return l
    }()
    
    let intro: UILabel = {
        let l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 12)
        l.textColor = Pen.label(.secondary)
        l.text = "发电赚收益，理财有所依，多种理财任你选".localized
        return l
    }()
   
    override init(frame: CGRect) {
        bannerView = BannerView<BannerItem>(frame: .zero)
        super.init(frame: frame)

        addSubview(bannerView)
        createBindView()
    }
    
    func createBindView() {
        
        let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 5
        addSubview(container)
        container.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(80)
            make.width.equalTo(350)
            make.centerY.equalTo(bannerView.snp.bottom)
        }
        
        let warn = UIImageView(image: UIImage.init(named: "home_location_goal"))
        container.addSubview(warn)
        warn.snp.makeConstraints { (make) in
            make.centerY.equalTo(container.snp.centerY)
            make.left.equalTo(container.snp.left).offset(20)
        }
        
        let stack = UIStackView(arrangedSubviews: [make, intro])
        stack.axis = .vertical
        stack.spacing = 8
        container.addSubview(stack)
        stack.snp.makeConstraints { (make) in
            make.centerY.equalTo(container.snp.centerY)
            make.left.equalTo(warn.snp.right).offset(15)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bannerView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(334)
        }
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    
 
    
class BannerItem: UIView {
    
    var imageView: UIImageView
    
    override init(frame: CGRect) {
        
        imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
//        imageView.layer.cornerRadius = 4
        super.init(frame: frame)
        
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
