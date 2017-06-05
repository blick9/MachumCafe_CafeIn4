//
//  BookmarkViewCell.swift
//  MachumCafe
//
//  Created by   minjae on 2017. 5. 1..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class BookmarkViewCell: UICollectionViewCell {
    @IBOutlet weak var bookmarkCafeImage: UIImageView!
    @IBOutlet weak var bookmarkCafeName: UILabel!
    @IBOutlet weak var bookmarkCafeAddress: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 6
    }
}
