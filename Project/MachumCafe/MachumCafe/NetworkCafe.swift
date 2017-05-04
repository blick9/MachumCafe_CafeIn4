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
    
    // MARK: 카페 목록 데이터모델에 저장
    static func getAllCafeList(callback: @escaping (_ modelCafe: [ModelCafe]) -> Void) {
        var modelCafe = [ModelCafe]()

        Alamofire.request("\(url)/api/v1/cafe").responseJSON { (response) in
            let cafes = JSON(data: response.data!).arrayValue
            let _ = cafes.map {
                let cafe = $0.dictionaryValue
                if let id = cafe["_id"]?.stringValue,
                let name = cafe["name"]?.stringValue,
                let phoneNumber = cafe["phoneNumber"]?.stringValue,
                let address = cafe["address"]?.stringValue,
                let hours = cafe["hours"]?.stringValue,
                let latitude = cafe["latitude"]?.stringValue,
                let longitude = cafe["longitude"]?.stringValue,
                let category = cafe["category"]?.arrayValue.map({ $0.stringValue }),
                let imagesName = cafe["imagesName"]?.arrayValue.map({ $0.stringValue }) {
                    let summary = cafe["summary"]?.stringValue
                    let mainMenu = cafe["mainMenu"]?.arrayValue.map({ $0.stringValue })

                    modelCafe.append(ModelCafe(id: id, name: name, phoneNumber: phoneNumber, address: address, hours: hours, latitude: latitude, longitude: longitude, category: category, summary: summary, mainMenu: mainMenu, imagesName: imagesName))
                }
            }
            callback(modelCafe)
        }
    }
    
    // MARK: 카페 이미지 데이터모델에 저장
    // TODO: 사진 콜백으로 빼기
    static func getImagesData(imagesName: [String], cafe: ModelCafe) {
        
        for imageName in imagesName {
            Alamofire.request("\(url)/api/v1/cafe/\(imageName)").responseData(completionHandler: { (response) in
                cafe.setImagesData(imageData: response.result.value!)
            })
        }
    }
    
    
}
