//
//  RatingView.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 5. 27..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class RatingView: UIView {
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingStarImage: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundView.layer.cornerRadius = CGFloat(self.frame.height / 6)
        self.layer.cornerRadius = CGFloat(self.frame.height / 6)
    }
}
