//
//  AssetCell.swift
//  GEBlockChain
//
//  Created by nan li on 2020/7/29.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class AssetCell: BaseCell {

    let addr: UILabel = {
        let l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 16)
        l.textColor = Pen.label(.primary)
        return l
    }()
    
    let more: UIButton = {
        let btn = UIButton()
        btn.setTitle("更多期限".localized, for: .normal)
        btn.setTitleColor("#B3CCE7".colorful(), for: .normal)
        btn.backgroundColor = "#EEF4F9".colorful()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return btn
    }()
    
    let join: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = Pen.view(.basement)
        btn.layer.cornerRadius = 16.s6h()
        btn.setTitle("立即参与".localized, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return btn
    }()
    
    let earn: UILabel = {
        let l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 16)
        l.textColor = "#FF6E12".colorful()
        return l
    }()
    
    let earnC: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 14)
        l.textColor = Pen.label(.secondary)
        l.text = "业绩比较基准".localized
        return l
    }()
    
    let length: UILabel = {
        let l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 16)
        l.textColor = Pen.label(.primary)
        return l
    }()
    
    let lengthC: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 14)
        l.textColor = Pen.label(.secondary)
        l.text = "投资期限".localized
        return l
    }()
    
    let highlightsContainer: UIStackView = {
        let s = UIStackView()
        s.spacing = 10
        return s
    }()
    
    var bussiness: Bussiness?  {
        
        didSet {
            addr.text = bussiness?.assetName
            length.text = bussiness?.unitStr
            earn.text = bussiness?.earnStr
            guard let hightlights = bussiness?.highlights?.components(separatedBy: "，") else {
                return
            }
            for e in hightlights.enumerated() {
                let l = UILabelPadding()
                l.text = e.element
                l.layer.cornerRadius = 1
                l.layer.borderColor = "#C0DAEF".colorful().cgColor
                l.layer.borderWidth = 1
                l.textColor = "#6FA8E3".colorful()
                l.font = UIFont.systemFont(ofSize: 12, weight: .medium)
                l.textAlignment = .center
                l.padding = UIEdgeInsets(top: 3, left: 5, bottom: 3, right: 5)
                l.backgroundColor = "#EEF4F9".colorful()
                highlightsContainer.addArrangedSubview(l)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Pen.view(.backColor)
        createBindView()
    }
    
    func createBindView() {
        
        let backView = UIView()
        backView.backgroundColor = .white
        backView.layer.cornerRadius = 5
        contentView.addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12))
        }
        
        let warn = UIImageView(image: UIImage(named: "home_location"))
        warn.contentMode = .scaleAspectFit
        let addrStack = UIStackView(arrangedSubviews: [warn, addr, more])
        addrStack.spacing = 8
        backView.addSubview(addrStack)
        addrStack.snp.makeConstraints { (make) in
            make.right.equalTo(backView)
            make.left.equalTo(backView.snp.left).offset(12)
            make.top.equalTo(backView.snp.top).offset(22.s6h())
            make.height.equalTo(30)
        }
        
        warn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 12, height: 14))
        }
        
        more.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 68, height: 30))
        }
        
        let container = UIView()
        backView.addSubview(container)
        container.snp.makeConstraints { (make) in
            make.left.right.equalTo(backView)
            make.top.equalTo(addrStack.snp.bottom).offset(24.s6h())
        }
        
        let left = UIStackView(arrangedSubviews: [earn, earnC])
        left.axis = .vertical
        left.spacing = 15
        container.addSubview(left)
        left.snp.makeConstraints { (make) in
            make.left.equalTo(container.snp.left).offset(35)
            make.top.bottom.equalTo(container)
        }
        
        let right = UIStackView(arrangedSubviews: [length, lengthC])
        right.axis = .vertical
        right.spacing = 15
        container.addSubview(right)
        right.snp.makeConstraints { (make) in
            make.left.equalTo(left.snp.right).offset(35)
            make.top.bottom.equalTo(container)
        }
        
        container.addSubview(join)
        join.snp.makeConstraints { (make) in
            make.centerY.equalTo(right.snp.centerY)
            make.right.equalTo(container.snp.right).offset(-10)
            make.size.equalTo(CGSize(width: 84, height: 32.s6h()))
        }
        
        backView.addSubview(highlightsContainer)
        highlightsContainer.snp.makeConstraints { (make) in
            make.left.equalTo(left)
            make.bottom.equalTo(backView.snp.bottom).offset((-20.s6h()))
            make.height.equalTo(20.s6h())
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
