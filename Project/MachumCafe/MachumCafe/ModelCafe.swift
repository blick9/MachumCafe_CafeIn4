//
//  ModelCafe.swift
//  MachumCafe
//
//  Created by HannaJeon on 2017. 4. 28..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import Foundation

class ModelCafe {
    
    fileprivate var id : String?
    fileprivate var name = String()
    fileprivate var tel : String?
    fileprivate var address = String()
    fileprivate var hours : String?
    fileprivate var latitude : Double?
    fileprivate var longitude : Double?
    fileprivate var category = [String]()
    fileprivate var menu : String?
    fileprivate var imagesURL = [String]()
    fileprivate var imagesData : [Data]?
    
    init() {}
        
    init(id: String? = nil, name: String, tel: String?, address: String, hours: String?, latitude: Double? = nil, longitude: Double? = nil, category: [String],  menu: String?, imagesURL: [String]) {
        self.id = id
        self.name = name
        self.tel = tel
        self.address = address
        self.hours = hours
        self.latitude = latitude
        self.longitude = longitude
        self.category = category
        self.menu = menu
        self.imagesURL = imagesURL
        self.imagesData = [Data]()
    }
    
    func setImagesData(imageData: Data) {
        self.imagesData?.append(imageData)
    }
    
    func getCafe() -> [String : Any] {
        var cafeDic = [String : Any]()
        cafeDic["id"] = id
        cafeDic["name"] = name
        cafeDic["tel"] = tel
        cafeDic["address"] = address
        cafeDic["hours"] = hours
        cafeDic["latitude"] = latitude
        cafeDic["longitude"] = longitude
        cafeDic["category"] = category
        cafeDic["menu"] = menu
        cafeDic["imagesURL"] = imagesURL
        cafeDic["imagesData"] = imagesData
        return cafeDic
    }
    
    func getLatitude() -> Double {
        return latitude!
    }
    
    func getLongitude() -> Double {
        return longitude!
    }
}

class Cafe {
    static let sharedInstance = Cafe()
    var cafeList = [ModelCafe]()
    var bookmarkList = [ModelCafe]()
}
