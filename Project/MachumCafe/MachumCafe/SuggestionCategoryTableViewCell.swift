//
//  SuggestionCategoryTableViewCell.swift
//  MachumCafe
//
//  Created by Danb on 2017. 5. 4..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit
import Foundation

class SuggestionCategoryTableViewCell: UITableViewCell {
    var selectedButton : category.categoryButton = .parking
    
    @IBOutlet weak var pickedImage1: UIImageView!
    @IBOutlet weak var pickedImage2: UIImageView!
    @IBOutlet weak var pickedImage3: UIImageView!
    
//    @IBAction func ImagePickerActionButton(_ sender: Any) {
//        
//    }
//    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    override func layoutSubviews() {
        
    }
   
    func selected(_ button:UIButton) {
        button.isSelected = !button.isSelected
        button.alpha = button.isSelected ? 1 : 0.5
        switch button.tag {
        case 1:
            selectedButton = .parking
        case 2:
            selectedButton = .smoking
        case 3:
            selectedButton = .restroom
        default:
            break
        }
    }
}



