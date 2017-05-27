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
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingStarImageView: UIImageView!
    @IBOutlet weak var ratingView: UIView!
    
    override func layoutSubviews() {
        self.bookmarkButton.setImage(#imageLiteral(resourceName: "Bookmark_Bt"), for: .normal)
        self.bookmarkButton.setImage(#imageLiteral(resourceName: "Bookmarked_Bt"), for: .selected)
        ratingLabel.layer.cornerRadius = 4
        ratingLabel.layer.backgroundColor = UIColor(red: 255, green: 232, blue: 129).cgColor
    
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
