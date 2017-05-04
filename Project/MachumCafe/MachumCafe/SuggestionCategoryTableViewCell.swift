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
    

    @IBOutlet weak var parkingButton: UIButton!
    @IBOutlet weak var smokingButton: UIButton!
    @IBOutlet weak var restroomButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        parkingButton.addTarget(self, action: #selector(selected(_:)), for: .touchUpInside)
        smokingButton.addTarget(self, action: #selector(selected(_:)), for: .touchUpInside)
        restroomButton.addTarget(self, action: #selector(selected(_:)), for: .touchUpInside)
        
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



