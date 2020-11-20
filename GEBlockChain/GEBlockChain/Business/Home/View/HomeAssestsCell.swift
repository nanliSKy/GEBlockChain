//
//  HomeAssestsCell.swift
//  GEBlockChain
//
//  Created by nan li on 2020/11/19.
//  Copyright © 2020 darchain. All rights reserved.
//

import UIKit

class HomeAssestsCell: UITableViewCell {

    
    @IBOutlet weak var assestTitle: UILabel!
    
    @IBOutlet weak var assestRate: UILabel!
    
    @IBOutlet weak var assestTime: UILabel!
    
    @IBOutlet weak var numbers: UILabel!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var assestPrice: UILabel!
    @IBOutlet weak var hightlightContainer: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        addHightlightsView()
        // Initialization code
    }
    
    func addHightlightsView() {
        let l: UILabelPadding = UILabelPadding()
        l.textAlignment = .center
        l.textColor = Pen.label(.blue)
        l.backgroundColor = "#EEF4F9".colorful()
        l.layer.cornerRadius = 1
        l.layer.borderWidth = 1
        l.layer.borderColor = "#C0DAEF".colorful().cgColor
        l.font = UIFont.systemFont(ofSize: 12)
        l.padding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        l.text = "政府扶持"
        hightlightContainer.addArrangedSubview(l)
        
        let ll: UILabelPadding = UILabelPadding()
        ll.textAlignment = .center
        ll.textColor = Pen.label(.blue)
        ll.backgroundColor = "#EEF4F9".colorful()
        ll.layer.cornerRadius = 1
        ll.layer.borderWidth = 1
        ll.layer.borderColor = "#C0DAEF".colorful().cgColor
        ll.font = UIFont.systemFont(ofSize: 12)
        ll.padding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        ll.text = "沙漠发电"
        hightlightContainer.addArrangedSubview(ll)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
