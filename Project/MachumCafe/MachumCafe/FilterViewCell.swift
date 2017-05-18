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
    @IBOutlet weak var categoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        category.sizeThatFits(CGSize(width: <#T##Double#>, height: <#T##Double#>)
//    }
    
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? UIColor(red: 255, green: 232, blue: 129) : UIColor.clear
        }
    }
    
}
