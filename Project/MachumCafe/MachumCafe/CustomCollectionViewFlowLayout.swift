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
        var xPoint: CGFloat = collectionView!.frame.maxX
        var maxY: CGFloat = -1
        var rowSize = [[CGFloat]]()
        var currentRow = 0
        
        attributes.forEach { layout in
            if xPoint + layout.frame.width + minimumInteritemSpacing >= collectionView!.frame.maxX {
                xPoint = 8
                layout.frame.origin.y = rowSize.isEmpty ? 0 : maxY + minimumLineSpacing
                if rowSize.count == 0 {
                    rowSize = [[xPoint, 0]]
                } else {
                    rowSize.append([xPoint, 0])
                    currentRow += 1
                }
            }
            layout.frame.origin.x = xPoint
            xPoint += layout.frame.width + minimumInteritemSpacing
            maxY = max(layout.frame.maxY, maxY)
            rowSize[currentRow][1] = xPoint - minimumInteritemSpacing
        }
        
        xPoint = 8
        maxY = -1.0
        currentRow = 0
        
        attributes.forEach { layout in
            if layout.frame.origin.y >= maxY {
                xPoint = 8
                let rowWidth = rowSize[currentRow][1] - rowSize[currentRow][0]
                let appendedMargin = (collectionView!.frame.width - 8 - rowWidth - 8) / 2
                xPoint += appendedMargin
                currentRow += 1
            }
            layout.frame.origin.x = xPoint
            xPoint += layout.frame.width + minimumInteritemSpacing
            maxY = max(layout.frame.maxY, maxY)
        }
        
        return attributes
    }
    
}

