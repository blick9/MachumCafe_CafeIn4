//
//  reviewTableViewCell.swift
//  MachumCafe_Practice
//
//  Created by Danb on 2017. 4. 25..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class reviewTableViewCell: UITableViewCell {

    @IBOutlet weak var reviewProfil: UIImageView!
    @IBOutlet weak var reviewerNickName: UILabel!
    @IBOutlet weak var reviewDescribe: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
