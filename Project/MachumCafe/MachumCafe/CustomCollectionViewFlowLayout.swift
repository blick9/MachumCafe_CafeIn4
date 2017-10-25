//
//  CustomCollectionViewFlowLayout.swift
//  MachumCafe
//
//  Created by HannaJeon on 2017. 9. 25..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import Foundation

class CustomCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superAttributes = super.layoutAttributesForElements(in: rect) else { return nil }
        guard let attributes = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes] else { return nil }

        var xPoint: CGFloat = 0
        var maxY: CGFloat = -1.0
        var rowSizes: [CGFloat] = []
        var currentRow: Int = 0
        attributes.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                xPoint = 0
                
                if rowSizes.count == 0 {
                    rowSizes = [xPoint]
                } else {
                    rowSizes.append(xPoint)
                    currentRow += 1
                }
            }
            layoutAttribute.frame.origin.x = xPoint
            xPoint += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
            rowSizes[currentRow] = xPoint - minimumInteritemSpacing
        }
        
        xPoint = 0
        maxY = -1.0
        currentRow = 0
        
        attributes.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                xPoint = 0
                let rowWidth = rowSizes[currentRow]
                let appendedMargin = (collectionView!.frame.width - rowWidth) / 2
                xPoint += appendedMargin
                currentRow += 1
            }
            layoutAttribute.frame.origin.x = xPoint
            xPoint += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        
        return attributes
    }
    
}

