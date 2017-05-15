//
//  SuggestionImagePickerViewCollectionViewCell.swift
//  MachumCafe
//
//  Created by Danb on 2017. 5. 11..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit
import Photos

class SuggestionImagePickerViewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoLibraryImage: UIImageView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var checkIcon: UIImageView!
    
    override var isSelected: Bool {
        didSet {
            overlayView.alpha = isSelected ? 0.6 : 0
            checkIcon.alpha = isSelected ? 1 : 0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkIcon.image = #imageLiteral(resourceName: "checkIcon")
        isSelected = false
    }
}
