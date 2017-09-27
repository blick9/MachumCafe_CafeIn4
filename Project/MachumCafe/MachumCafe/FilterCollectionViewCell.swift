//
//  FilterCollectionViewCell.swift
//  MachumCafe
//
//  Created by HannaJeon on 2017. 5. 20..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var listCategory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? UIColor(red: 255, green: 232, blue: 129) : UIColor.clear
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height/2
        self.layer.borderWidth = 1.7
        self.layer.borderColor = UIColor.init(red: 255, green: 232, blue: 129).cgColor
        category.textColor = UIColor.init(red: 51, green: 51, blue: 51)
        category.sizeToFit()
    }
}
