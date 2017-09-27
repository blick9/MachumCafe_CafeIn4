//
//  reviewTableViewCell.swift
//  MachumCafe_Practice
//
//  Created by Danb on 2017. 4. 25..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class CafeDetailReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var reviewProfil: UIImageView!
    @IBOutlet weak var reviewerNickName: UILabel!
    @IBOutlet weak var reviewDescribe: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
