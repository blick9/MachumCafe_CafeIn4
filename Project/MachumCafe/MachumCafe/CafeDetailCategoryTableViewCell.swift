//
//  CafeDetailCategoryTableViewCell.swift
//  MachumCafe
//
//  Created by Danb on 2017. 5. 2..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class CafeDetailCategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryIcon1: UIImageView!
    @IBOutlet weak var categoryIcon2: UIImageView!
    @IBOutlet weak var categoryIcon3: UIImageView!
    @IBOutlet weak var detailCategoryView: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
