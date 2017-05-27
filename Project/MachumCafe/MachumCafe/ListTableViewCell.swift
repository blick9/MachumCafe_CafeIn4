//
//  ListTableViewCell.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 4. 25..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var cafeNameLabel: UILabel!
    @IBOutlet weak var cafeAddressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var category: UILabel!
    var ratingLable = String()
    
    override func layoutSubviews() {
        self.bookmarkButton.setImage(#imageLiteral(resourceName: "Bookmark_Bt"), for: .normal)
        self.bookmarkButton.setImage(#imageLiteral(resourceName: "Bookmarked_Bt"), for: .selected)
        self.cafeNameLabel.sizeToFit()
        if let ratingViewxib = Bundle.main.loadNibNamed("RatingView", owner: self, options: nil)?.first as? RatingView {
            ratingViewxib.frame = CGRect(x: cafeNameLabel.frame.width+20, y: 100, width: 44, height: 16)
            ratingViewxib.ratingLabel.text = ratingLable
            self.addSubview(ratingViewxib)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
