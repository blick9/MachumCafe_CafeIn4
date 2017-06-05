//
//  ReviewTableViewCell.swift
//  MachumCafe
//
//  Created by   minjae on 2017. 5. 15..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit
import Cosmos

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var reviewer: UILabel!
    @IBOutlet weak var reviewDate: UILabel!
    @IBOutlet weak var reviewStarRating: CosmosView!
    @IBOutlet weak var reviewContent: UILabel!
    @IBOutlet weak var reviewerPicture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reviewerPicture.layer.cornerRadius = CGFloat(reviewerPicture.frame.height / 2)
        reviewerPicture.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
