//
//  FilterViewCell.swift
//  MachumCafe
//
//  Created by   minjae on 2017. 5. 14..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class FilterViewCell: UICollectionViewCell {
    @IBOutlet weak var category: UILabel!
    
    override func awakeFromNib() {
        isSelected = false
    }
    
    override var isSelected: Bool {
        didSet {
            category.backgroundColor = isSelected ? UIColor(red: 255, green: 232, blue: 129) : UIColor.clear
        }
    }
    
}
