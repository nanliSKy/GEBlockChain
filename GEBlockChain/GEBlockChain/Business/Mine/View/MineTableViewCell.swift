//
//  MineTableViewCell.swift
//  GEBlockChain
//
//  Created by nan li on 2020/8/18.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import ReactiveSwift

class MineTableViewCell: BaseCell {

    lazy var mineC:[MineC] = {
        var c = [MineC]()
        let s1 = MineC(content: "账户余额".localized, iamge: "mine_asset")
        c.append(s1)
        let s2 = MineC(content: "我的资产".localized, iamge: "mine_assets_exchange")
        c.append(s2)
        let s3 = MineC(content: "充值".localized, iamge: "mine_assets_in")
        c.append(s3)
        let s4 = MineC(content: "提现".localized, iamge: "mine_assets_out")
        c.append(s4)
        let s5 = MineC(content: "我的挂单".localized, iamge: "mine_pendOrder")
        c.append(s5)
        let s6 = MineC(content: "优惠券".localized, iamge: "mine_coupon")
        c.append(s6)
        let s7 = MineC(content: "邀请好友".localized, iamge: "mine_invate_friends")
        c.append(s7)
        let s8 = MineC(content: "银行卡".localized, iamge: "mine_bank")
        c.append(s8)
        return c
    }()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: (Int.sw()-30)/4.0, height: 85)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MineCollectionViewCell.self)
//        collectionView.register(MineCollectionViewCell.self, forCellWithReuseIdentifier: MineCollectionViewCell.className())
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    lazy var selectControllerIndex = MutableProperty((true, 0))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = Pen.view(.viewBackgroundColor)
        let backView = UIView()
        contentView.addSubview(backView)
        backView.backgroundColor = .white
        backView.layer.cornerRadius = 8
        backView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15))
        }
        
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
        backView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(backView)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MineTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mineC.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MineCollectionViewCell.className(), for: indexPath) as! MineCollectionViewCell
        let cell: MineCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.mineC = mineC[indexPath.row]
        return cell
    }
}

extension MineTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectControllerIndex.value = (true, indexPath.row)
    }
}


class MineCollectionViewCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let i = UIImageView()
        i.contentMode = .scaleAspectFit
        return i
    }()
    
    let content: UILabel = {
        let l = UILabel()
        l.textColor = Pen.label(.primary)
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.text = "我的资产"
        return l
    }()
    
    var mineC: MineC? {
        didSet{
            imageView.image = UIImage(named: mineC?.iamge ?? "")
            content.text = mineC?.content
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
//            Pen.view(.viewBackgroundColor)
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(contentView.snp.top).offset(12)
        }
        contentView.addSubview(content)
        content.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(imageView.snp.bottom).offset(10)
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct MineC {
    let content: String
    let iamge: String
    
}
