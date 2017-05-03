//
//  NetworkBookmark.swift
//  MachumCafe
//
//  Created by HannaJeon on 2017. 4. 28..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import Foundation
import Alamofire

class NetworkBookmark {
    
    private static let url = URLpath.getURL()
    
    // MARK: 즐겨찾기 목록 데이터모델에 저장
    static func getMyBookmark(userId: String, callback: @escaping (_ message: Bool, _ cafeList: [ModelCafe], _ userBookmark: [String]) -> Void) {
        var message = Bool()
        var cafeList = [ModelCafe]()
        var userBookmark = [String]()
        
        Alamofire.request("\(url)/api/v1/bookmark/\(userId)").responseJSON { (response) in
            if let res = response.result.value as? [String : Any] {
                if let resMessage = res["message"] as? Bool {
                    message = resMessage
                }
                if let cafes = res["cafe"] as? [[String : Any]] {
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
                        let category = cafe["category"] as? [String],
                        let imagesName = cafe["imagesName"] as? [String] {
                            let modelCafe = ModelCafe(id: id, name: name, phoneNumber: phoneNumber, address: address, hours: hours, latitude: latitude, longitude: longitude, category: category, summary: summary, mainMenu: mainMenu, imagesName: imagesName)
                            cafeList.append(modelCafe)
                        }
                    }
                }
                if let resUserBookmark = res["userBookmark"] as? [String] {
                    userBookmark = resUserBookmark
                }
            }
            callback(message, cafeList, userBookmark)
        }
    }

    // MARK: 즐겨찾기 추가 & 삭제
    static func setMyBookmark(userId: String, cafeId: String, callback: @escaping (_ message: Bool, _ description: String) -> Void) {
        var message = Bool()
        var description = String()
        
        let parameters : Parameters = ["cafeId" : cafeId]
        
        Alamofire.request("\(url)/api/v1/bookmark/\(userId)", method: .put, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            if let res = response.result.value as? [String : Any] {
                if let resMessage = res["message"] as? Bool {
                    message = resMessage
                }
                if let resDescription = res["description"] as? String {
                    description = resDescription
                }
            }
            callback(message, description)
        }
    }
    
}
