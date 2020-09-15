//
//  MineTableHeaderView.swift
//  GEBlockChain
//
//  Created by nan li on 2020/8/18.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class MineTableHeaderView: UIView {

    let avatar: UIImageView = {
        let avatar = UIImageView(image: UIImage(named: "mine_avatar"))
        avatar.contentMode = .scaleAspectFit
        return avatar
    }()
    
    let name: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.font = UIFont.boldSystemFont(ofSize: 18)
        l.text = "解可眉"
        return l
    }()
    
    let cert: UIButton = {
        let b = UIButton(type: .custom)
        b.setTitle("请实名认证".localized, for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return b
    }()
    
    let waitEarnIntro: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = Pen.label(.primary)
        l.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        l.text = "待结算收益".localized
        return l
    }()
    
    let waitEarn: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = Pen.view(.basement)
        l.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        l.text = "7625.91元"
        return l
    }()
    
    let yesterEarnIntro: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = Pen.label(.primary)
        l.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        l.text = "昨日预计收益".localized
        return l
    }()
    
    let yesterEarn: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = Pen.view(.basement)
        l.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        l.text = "7625.91元"
        return l
    }()
    
    let balanceEarnIntro: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = Pen.label(.primary)
        l.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        l.text = "余额账户".localized
        return l
    }()
    
    let balanceEarn: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = Pen.view(.basement)
        l.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        l.text = "7625.91元"
        return l
    }()
    
    let gradientBackView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    func createBindView() {
        
        addSubview(gradientBackView)
        gradientBackView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(198.s6h())
        }
        gradientBackView.addSubview(avatar)
        avatar.snp.makeConstraints { (make) in
            make.width.height.equalTo(60.s6w())
            make.centerY.equalTo(gradientBackView.snp.centerY)
            make.left.equalTo(gradientBackView.snp.left).offset(25)
        }
        let nameCertContainer = UIStackView(arrangedSubviews: [name, cert])
        nameCertContainer.axis = .vertical
        nameCertContainer.spacing = 5
        gradientBackView.addSubview(nameCertContainer)
        nameCertContainer.snp.makeConstraints { (make) in
            make.centerY.equalTo(avatar.snp.centerY)
            make.left.equalTo(avatar.snp.right).offset(10)
        }
        
        let earnContainer: UIView = {
            let v = UIView()
            v.backgroundColor = .white
            v.layer.cornerRadius = 8
            return v
        }()
        
        addSubview(earnContainer)
        earnContainer.snp.makeConstraints { (make) in
            make.centerY.equalTo(gradientBackView.snp.bottom)
            make.height.equalTo(90.s6h())
            make.left.equalTo(self.snp.left).offset(15)
            make.right.equalTo(self.snp.right).offset(-15)
        }
        
        let waitContainer = UIStackView(arrangedSubviews: [waitEarnIntro, waitEarn])
        waitContainer.axis = .vertical
        waitContainer.spacing = 12
        let waitLineYester = UIView()
        waitLineYester.backgroundColor = "#EBF6F2".colorful()
        
        let yesterContainer = UIStackView(arrangedSubviews: [yesterEarnIntro, yesterEarn])
        yesterContainer.axis = .vertical
        yesterContainer.spacing = 12
        let yesterLineBalance = UIView()
        yesterLineBalance.backgroundColor = "#EBF6F2".colorful()
        
        let balanceContainer = UIStackView(arrangedSubviews: [balanceEarnIntro, balanceEarn])
        balanceContainer.axis = .vertical
        balanceContainer.spacing = 12
        
        let earnContainerView = UIStackView(arrangedSubviews: [waitContainer, waitLineYester, yesterContainer, yesterLineBalance, balanceContainer])
        earnContainerView.alignment = .center
        earnContainer.addSubview(earnContainerView)
        earnContainerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        waitContainer.snp.makeConstraints { (make) in
            make.width.equalTo(yesterContainer)
        }
        balanceContainer.snp.makeConstraints { (make) in
            make.width.equalTo(yesterContainer)
        }
        
        waitLineYester.snp.makeConstraints { (make) in
            make.width.equalTo(1)
            make.height.equalTo(35)
        }
        yesterLineBalance.snp.makeConstraints { (make) in
            make.width.height.equalTo(waitLineYester)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createBindView()
        gradientBackView.addTransitionColor(sc: "#6FB0F2".colorful(), ec: "#0882FE".colorful(), sp: CGPoint(x: 0, y: 0), ep: CGPoint(x: 1, y: 0))
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
