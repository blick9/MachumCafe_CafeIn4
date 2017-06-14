//
//  PhotoLibrary.swift
//  MachumCafe
//
//  Created by HannaJeon on 2017. 6. 14..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit
import Photos

class PhotoLibrary {
    private var imageManager: PHImageManager
    private var requestOptions: PHImageRequestOptions
    private var fetchOptions: PHFetchOptions
    private var fetchResult: PHFetchResult<PHAsset>
    private var count: Int
    
    init() {
        imageManager = PHImageManager.default()
        requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .opportunistic
        fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        count = fetchResult.count
    }
    
    func getCount() -> Int {
        return count
    }
    
    func setPhoto(at index: Int, callback: @escaping (UIImage?) -> Void) {
        if index < fetchResult.count {
            imageManager.requestImage(for: fetchResult.object(at: index), targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: requestOptions, resultHandler: { (image, _) in
                callback(image)
            })
        } else {
            callback(nil)
        }
    }
    
}
