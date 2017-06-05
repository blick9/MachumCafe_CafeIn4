//
//  SuggestionCategory.swift
//  MachumCafe
//
//  Created by Danb on 2017. 5. 4..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit
import Foundation

class PreviewImageButton : UIButton {
    
    var tempImage = UIImage()
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override var isSelected: Bool {
        didSet {
            self.setBackgroundImage(nil, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
