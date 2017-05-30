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
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func layoutSubviews() {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(red: 255, green: 232, blue: 129)
        self.layer.cornerRadius = CGFloat(self.frame.height / 6)
    }
}
