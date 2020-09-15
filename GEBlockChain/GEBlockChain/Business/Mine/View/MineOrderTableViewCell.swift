//
//  MineOrderTableViewCell.swift
//  GEBlockChain
//
//  Created by nan li on 2020/8/18.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class MineOrderTableViewCell: BaseCell {

    lazy var mineC:[MineC] = {
            var c = [MineC]()
            let s1 = MineC(content: "待付款".localized, iamge: "mine_paying")
            c.append(s1)
            let s2 = MineC(content: "挂单中".localized, iamge: "mine_pending_order")
            c.append(s2)
            let s3 = MineC(content: "收益中".localized, iamge: "mine_assets_earning")
            c.append(s3)
            let s4 = MineC(content: "已取消".localized, iamge: "mine_order_cancel")
            c.append(s4)
            let s5 = MineC(content: "已完成".localized, iamge: "mine_order_done")
            c.append(s5)
         
            return c
        }()
        let collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout.init()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.itemSize = CGSize(width: (Int.sw()-30)/5.0, height: 90.s6w())
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.register(MineCollectionViewCell.self, forCellWithReuseIdentifier: MineCollectionViewCell.className())
            collectionView.backgroundColor = .white
            return collectionView
        }()
        
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
            backgroundColor = "#FBFCFE".colorful()
            let backView = UIView()
            contentView.addSubview(backView)
            backView.backgroundColor = .white
            backView.layer.cornerRadius = 8
            backView.snp.makeConstraints { (make) in
                make.edges.equalTo(UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15))
            }
            
            let orderContainer = UIView()
            orderContainer.backgroundColor = "#FBFCFE".colorful()
            backView.addSubview(orderContainer)
            orderContainer.snp.makeConstraints { (make) in
                make.left.right.top.equalTo(backView)
                make.height.equalTo(40.s6h())
            }
            
            
            let order = UILabel()
            order.text = "我的订单".localized
            order.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            order.textColor = Pen.label(.primary)
            orderContainer.addSubview(order)
            order.snp.makeConstraints { (make) in
                make.top.bottom.equalToSuperview()
                make.left.equalTo(backView.snp.left).offset(20)
            }
            
            collectionView.dataSource = self
            backView.addSubview(collectionView)
            collectionView.snp.makeConstraints { (make) in
                make.left.right.bottom.equalToSuperview()
                make.top.equalTo(order.snp.bottom)
            }
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }

    extension MineOrderTableViewCell: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return mineC.count
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MineCollectionViewCell.className(), for: indexPath) as! MineCollectionViewCell
            cell.mineC = mineC[indexPath.row]
            return cell
        }
    }

   