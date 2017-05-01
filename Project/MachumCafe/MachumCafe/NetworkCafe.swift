//
//  Cafe.swift
//  MachumCafe
//
//  Created by HannaJeon on 2017. 4. 27..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import Foundation
import Alamofire

class NetworkCafe {
    
    // MARK: 카페 목록 데이터모델에 저장
    static func getAllCafeList(callback: @escaping (_ result: [ModelCafe]) -> Void) {
        let url = URLpath.getURL()
        var result = [ModelCafe]()

        Alamofire.request("\(url)/api/v1/cafe").responseJSON { (response) in
            if let cafes = response.result.value as? [[String : Any]] {
                for cafe in cafes {
                    var summary : String?
                    var mainMenu : [String]?
                    
                    if let isSummary = cafe["summary"] as? String {
                        summary = isSummary
                    }
                    if let isMainMenu = cafe["mainMenu"] as? [String] {
                        mainMenu = isMainMenu
                    }
                    if let id = cafe["_id"] as? String,
                    let name = cafe["name"] as? String,
                    let phoneNumber = cafe["phoneNumber"] as? String,
                    let address = cafe["address"] as? String,
                    let hours = cafe["hours"] as? String,
                    let latitude = cafe["latitude"] as? String,
                    let longitude = cafe["longitude"] as? String,
                    let category = cafe["category"] as? [String] {
                        let modelCafe = ModelCafe(id: id, name: name, phoneNumber: phoneNumber, address: address, hours: hours, latitude: latitude, longitude: longitude, category: category, summary: summary, mainMenu: mainMenu)
                        result.append(modelCafe)
                    }
                }
            }
            callback(result)
        }
    }
    
    
}
