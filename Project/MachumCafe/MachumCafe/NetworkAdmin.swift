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
    static func uploadsImage(images: [UIImage], callback: @escaping (_ imagesURL: [String]) -> Void) {
        var imagesURL = [String]()
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for image in images {
                let imageData = UIImageJPEGRepresentation(image, 0.1)
                multipartFormData.append(imageData!, withName: "image", fileName: "file.png", mimeType: "image/png")
            }
        }, to: "\(url)/api/v1/admin/suggestion/uploads") { (result) in
            switch result {
            case .success(let upload, _, _):
                print("success")
                upload.responseJSON(completionHandler: { (response) in
                    imagesURL = JSON(data: response.data!).arrayValue.map{ $0.stringValue }
                    callback(imagesURL)
                })
            case .failure(let error):
                print("failed")
                print(error)
            }
        }
    }
    
    // MARK: 새로운 카페 제보
    static func suggestionNewCafe(cafe: ModelCafe) {
        Alamofire.request("\(url)/api/v1/admin/suggestion/newcafe", method: .post, parameters: cafe.getCafe(), encoding: JSONEncoding.default).responseJSON {_ in}
    }
    
    // MARK: 기존 카페 수정 제보
    static func suggestionEditCafe(cafe: [String:Any]) {
        Alamofire.request("\(url)/api/v1/admin/suggestion/editcafe", method: .post, parameters: cafe, encoding: JSONEncoding.default).responseJSON {_ in}
    }
    
    // MARK: 기존 카페 폐업 신고
    static func suggestionClesedCafe(cafe: [String:Any]) {
        var cafe = cafe
        cafe.removeValue(forKey: "imagesData")
        Alamofire.request("\(url)/api/v1/admin/suggestion/closedcafe", method: .post, parameters: cafe, encoding: JSONEncoding.default).responseJSON {_ in}
    }
}

    
