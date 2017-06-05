//
//  ListTableViewCell.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 4. 25..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    var ratingValue = String()
    var ratingViewxib = Bundle.main.loadNibNamed("RatingView", owner: self, options: nil)?.first as! RatingView
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var cafeNameLabel: UILabel!
    @IBOutlet weak var cafeAddressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var category: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.cafeNameLabel.sizeToFit()
        ratingViewxib.ratingLabel.text = ratingValue
        ratingViewxib.ratingStarImage.image = ratingValue == "0.0" ? #imageLiteral(resourceName: "RatingStarEmpty") : #imageLiteral(resourceName: "RatingStarFill")
        ratingViewxib.frame = CGRect(x: cafeNameLabel.frame.maxX + 5 , y: cafeNameLabel.frame.midY - 5, width: 44, height: 18)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bookmarkButton.setImage(#imageLiteral(resourceName: "Bookmark_Bt"), for: .normal)
        self.bookmarkButton.setImage(#imageLiteral(resourceName: "Bookmarked_Bt"), for: .selected)
        self.addSubview(ratingViewxib)
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
