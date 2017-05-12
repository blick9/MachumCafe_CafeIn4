//
//  NetworkAdmin.swift
//  MachumCafe
//
//  Created by HannaJeon on 2017. 5. 11..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkAdmin {
    
    private static let url = URLpath.getURL()
    
    // MARK: 이미지 업로드
    static func uploadsImage(images: [UIImage], callback: (_ imagesURL: [String]) -> Void) {
        var imagesURL = [String]()
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for image in images {
                let imageData = UIImageJPEGRepresentation(image, 0.1)
                multipartFormData.append(imageData!, withName: "image", fileName: "file.png", mimeType: "image/png")
            }
        }, to: "\(url)/admin/suggestion/uploads") { (result) in
            switch result {
            case .success(let upload, _, _):
                print("success")
                upload.responseJSON(completionHandler: { (response) in
                    let res = JSON(data: response.data!)
                    let message = res["message"].boolValue
                    if message {
                        let filename = res["filename"].arrayValue.map{ $0.stringValue }
                        imagesURL = filename
                    }
                })
            case .failure(let error):
                print("failed")
                print(error)
            }
        }
        callback(imagesURL)
    }
    
    static func newSuggestionCafe(imagesURL: [String]) {

    }
}

    
