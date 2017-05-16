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
       // self.setBackgroundImage(tempImage, for: .normal)
    }
    
//    func setBackground(image: UIImage) {
//        self.setBackgroundImage(tempImage, for: .normal)
//        print ("aaaaaaaaaaa")
//    }

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
//        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
      //  isSelected = false
        
    }
    
}


/*
class category {
    enum categoryButton {
        case parking, smoking, restroom
        func applyCategory() -> UIImage {
            switch self {
            case .parking:
                return #imageLiteral(resourceName: "parkingCategoryIcon")
            case .smoking:
                return #imageLiteral(resourceName: "smokingCategoryIcon")
            case .restroom:
                return #imageLiteral(resourceName: "restroomCategoryIcon")
                
            }
        }
    }
}
*/
