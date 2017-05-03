//
//  ModelCafe.swift
//  MachumCafe
//
//  Created by HannaJeon on 2017. 4. 28..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import Foundation

class ModelCafe {
    
    fileprivate var id = String()
    fileprivate var name = String()
    fileprivate var phoneNumber = String()
    fileprivate var address = String()
    fileprivate var hours = String()
    fileprivate var latitude = String()
    fileprivate var longitude = String()
    fileprivate var category = [String]()
    fileprivate var summary : String?
    fileprivate var mainMenu : [String]?
    fileprivate var imagesName = [String]()
    fileprivate var imagesData : [Data]?
    
    init() {}
        
    init(id: String, name: String, phoneNumber: String, address: String, hours: String, latitude: String, longitude: String, category: [String], summary: String?, mainMenu: [String]?, imagesName: [String]) {
        self.id = id
        self.name = name
        self.phoneNumber = phoneNumber
        self.address = address
        self.hours = hours
        self.latitude = latitude
        self.longitude = longitude
        self.category = category
        self.summary = summary
        self.mainMenu = mainMenu
        self.imagesName = imagesName
        self.imagesData = [Data]()
    }
    
    func setImagesData(imageData: Data) {
        self.imagesData?.append(imageData)
    }
    
    func getCafe() -> [String : Any] {
        var cafeDic = [String : Any]()
        cafeDic["id"] = id
        cafeDic["name"] = name
        cafeDic["phoneNumber"] = phoneNumber
        cafeDic["address"] = address
        cafeDic["hours"] = hours
        cafeDic["latitude"] = latitude
        cafeDic["longitude"] = longitude
        cafeDic["category"] = category
        cafeDic["summary"] = summary
        cafeDic["mainMenu"] = mainMenu
        cafeDic["imagesName"] = imagesName
        cafeDic["imagesData"] = imagesData
        return cafeDic
    }
}

class Cafe {
    static let sharedInstance = Cafe()
    var cafeList = [ModelCafe]()
    var bookmarkList = [ModelCafe]()
}
