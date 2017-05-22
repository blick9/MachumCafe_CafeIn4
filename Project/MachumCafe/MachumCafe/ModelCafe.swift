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
    fileprivate var reviews = [ModelReview]() {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshReview"), object: nil)
            print("Change!Review")
        }
    }
    
    init() {}
        
    init(id: String? = nil, name: String, tel: String?, address: String, hours: String?, latitude: Double? = nil, longitude: Double? = nil, category: [String],  menu: String? = nil, imagesURL: [String]) {
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
    
    func setReview(review: ModelReview) {
        reviews.append(review)
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

    func getReviews() -> [ModelReview] {
        return reviews
    }
}

class Cafe {
    static let sharedInstance = Cafe()
    var allCafeList = [ModelCafe]() {
        didSet {
            if self.allCafeList.count >= 1000 {
                self.allCafeList.removeFirst(300)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshMapMarkers"), object: nil)
            }
        }
    }
    var filterCafeList = [ModelCafe]() {
        didSet {
            if self.allCafeList.count >= 300 {
                self.allCafeList.removeFirst(100)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshMapMarkers"), object: nil)
            }
        }
    }
    var bookmarkList = [ModelCafe]()
}
