//
//  cafeDetailTableViewCell.swift
//  MachumCafe_Practice
//
//  Created by Danb on 2017. 4. 24..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class CafeDetailTableViewCell: UITableViewCell {

    @IBOutlet var detailLabel: [UILabel]!
    @IBOutlet var suggestionButton: [UIButton]!
    @IBOutlet weak var phoneCallButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        detailLabel.forEach { label in
            label.sizeToFit()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
