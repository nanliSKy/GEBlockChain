//
//  MineOrderTableViewCell.swift
//  GEBlockChain
//
//  Created by nan li on 2020/8/18.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit
import ReactiveSwift

class MineOrderTableViewCell: BaseCell {
 
    lazy var selectControllerIndex = MutableProperty(0)
    lazy var mineC:[MineC] = {
            var c = [MineC]()
            let s1 = MineC(content: "待付款".localized, iamge: "mine_paying")
            c.append(s1)
            let s2 = MineC(content: "已取消".localized, iamge: "mine_order_cancel")
            c.append(s2)
            let s3 = MineC(content: "已完成".localized, iamge: "mine_order_done")
            c.append(s3)
//            let s4 = MineC(content: "已取消".localized, iamge: "mine_order_cancel")
//            c.append(s4)
//            let s5 = MineC(content: "已完成".localized, iamge: "mine_order_done")
//            c.append(s5)
         
            return c
        }()
        let collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout.init()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.itemSize = CGSize(width: (Int.sw()-30)/3.0, height: 90.s6w())
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.register(MineOrderCollectionViewCell.self)
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
            backgroundColor = Pen.view(.viewBackgroundColor)
            let backView = UIView()
            contentView.addSubview(backView)
            backView.backgroundColor = .white
            backView.layer.cornerRadius = 8
            backView.snp.makeConstraints { (make) in
                make.edges.equalTo(UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15))
            }
            
            let orderContainer = UIView()
            orderContainer.backgroundColor = .white
            backView.addSubview(orderContainer)
            orderContainer.snp.makeConstraints { (make) in
                make.left.right.top.equalTo(backView)
                make.height.equalTo(40.s6h())
            }
            
            
//            let order = UILabel()
//            order.text = "我的订单".localized
//            order.font = UIFont.systemFont(ofSize: 15, weight: .medium)
//            order.textColor = Pen.label(.primary)
//            orderContainer.addSubview(order)
//            order.snp.makeConstraints { (make) in
//                make.top.bottom.equalToSuperview()
//                make.left.equalTo(backView.snp.left).offset(20)
//            }
            
            let button = UIButton()
            button.setTitleColor(Pen.view(.basement), for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            button.set(image: UIImage(named: "order_indicator"), title: "全部订单".localized, titlePosition: .left,
                       additionalSpacing: 14, state: .normal)
            orderContainer.addSubview(button)
            button.snp.makeConstraints { (make) in
                make.right.equalTo(orderContainer.right).offset(-12)
                make.top.bottom.equalToSuperview()
            }
            
            let lineView = UIView()
            lineView.backgroundColor = "#F2F2F4".colorful()
            orderContainer.addSubview(lineView)
            lineView.snp.makeConstraints { (make) in
                make.left.bottom.right.equalTo(orderContainer)
                make.height.equalTo(1)
            }
            
            
            collectionView.dataSource = self
            collectionView.delegate = self
            backView.addSubview(collectionView)
            collectionView.snp.makeConstraints { (make) in
                make.left.right.bottom.equalToSuperview()
                make.top.equalTo(button.snp.bottom)
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
            let cell: MineOrderCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            
            cell.mineC = mineC[indexPath.row]
            return cell
        }
    }

   

extension MineOrderTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectControllerIndex.value = indexPath.row
    }
}

class MineOrderCollectionViewCell: UICollectionViewCell {
    
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
        let stack:UIStackView = UIStackView(arrangedSubviews: [imageView, content])
        stack.axis = .horizontal
        stack.spacing = 6
        contentView.addSubview(stack)
        stack.snp.makeConstraints { (make) in
            make.center.equalTo(contentView.snp.center)
            
        }
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
