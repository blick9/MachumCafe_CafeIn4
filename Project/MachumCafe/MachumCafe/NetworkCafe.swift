//
//  Cafe.swift
//  MachumCafe
//
//  Created by HannaJeon on 2017. 4. 27..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkCafe {
    
    private static let url = URLpath.getURL()
    
    // MARK: 카페 목록 데이터모델에 저장, 팀원 전체 test 후 지울 예정
//    static func getAllCafeList(callback: @escaping (_ modelCafe: [ModelCafe]) -> Void) {
//        var modelCafe = [ModelCafe]()
//
//        Alamofire.request("\(url)/api/v1/cafe").responseJSON { (response) in
//            let cafes = JSON(data: response.data!).arrayValue
//            let _ = cafes.map {
//                let cafe = $0.dictionaryValue
//                
//                if let id = cafe["_id"]?.stringValue,
//                let name = cafe["name"]?.stringValue,
//                let address = cafe["address"]?.stringValue,
//                let longitude = cafe["location"]?.arrayValue[0].doubleValue,
//                let latitude = cafe["location"]?.arrayValue[1].doubleValue,
//                let category = cafe["category"]?.arrayValue.map({ $0.stringValue }),
//                let imagesURL = cafe["imagesURL"]?.arrayValue.map({ $0.stringValue }) {
//                    let tel = cafe["tel"]?.stringValue
//                    let hours = cafe["hours"]?.stringValue
//                    let menu = cafe["menu"]?.stringValue
//                    modelCafe.append(ModelCafe(id: id, name: name, tel: tel, address: address, hours: hours, latitude: latitude, longitude: longitude, category: category, menu: menu, imagesURL: imagesURL))
//                }
//            }
//            callback(modelCafe)
//        }
//    }
    
    // MARK: 카페 이미지 데이터모델에 저장
    static func getImagesData(imagesURL: [String], callback: @escaping (_ imageData: Data) -> Void) {
        if !imagesURL.isEmpty {
            for imageURL in imagesURL {
                Alamofire.request("\(imageURL)").responseData(completionHandler: { (response) in
                    if let imageData = response.result.value {
                        callback(imageData)
                    }
                })
            }
        }
    }
    
    // MARK: 현위치 반경 1km 내 카페목록 불러오기
    static func getCafeList(coordinate: ModelLocation, callback: @escaping (_ modelCafe: [ModelCafe]) -> Void) {
        var modelCafe = [ModelCafe]()
        
        Alamofire.request("\(url)/api/v1/cafe", method: .post, parameters: coordinate.getLocation(), encoding: JSONEncoding.default).responseJSON { (response) in
            let cafes = JSON(data: response.data!).arrayValue
            let _ = cafes.map {
                let cafe = $0.dictionaryValue
                
                if let id = cafe["_id"]?.stringValue,
                let name = cafe["name"]?.stringValue,
                let address = cafe["address"]?.stringValue,
                let longitude = cafe["location"]?.arrayValue[0].doubleValue,
                let latitude = cafe["location"]?.arrayValue[1].doubleValue,
                let category = cafe["category"]?.arrayValue.map({ $0.stringValue }),
                let imagesURL = cafe["imagesURL"]?.arrayValue.map({ $0.stringValue }) {
                    let tel = cafe["tel"]?.stringValue
                    let hours = cafe["hours"]?.stringValue
                    let menu = cafe["menu"]?.stringValue
                    modelCafe.append(ModelCafe(id: id, name: name, tel: tel, address: address, hours: hours, latitude: latitude, longitude: longitude, category: category, menu: menu, imagesURL: imagesURL))
                }
            }
            callback(modelCafe)
        }
    }
    
    
}
