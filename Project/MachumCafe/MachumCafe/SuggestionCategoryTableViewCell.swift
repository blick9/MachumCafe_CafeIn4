//
//  SuggestionCategoryTableViewCell.swift
//  MachumCafe
//
//  Created by Danb on 2017. 5. 4..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class SuggestionCategoryTableViewCell: UITableViewCell {

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

}
