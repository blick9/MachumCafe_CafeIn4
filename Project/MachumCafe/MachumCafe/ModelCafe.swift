//
//  ModelCafe.swift
//  MachumCafe
//
//  Created by HannaJeon on 2017. 4. 28..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import Foundation

class ModelCafe {
    
    private var id : String?
    private var name = String()
    private var tel : String?
    private var address = String()
    private var hours : String?
    private var latitude : Double?
    private var longitude : Double?
    private var category = [String]()
    private var rating = Double()
    private var menu : String?
    private var imagesURL = [String]()
    private var reviews = [ModelReview]() {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshReview"), object: nil)
        }
    }
    
    init() {}
        
    init(id: String? = nil, name: String, tel: String?, address: String, hours: String?, latitude: Double? = nil, longitude: Double? = nil, category: [String], rating: Double, menu: String? = nil, imagesURL: [String]) {
        self.id = id
        self.name = name
        self.tel = tel
        self.address = address
        self.hours = hours
        self.latitude = latitude
        self.longitude = longitude
        self.category = category
        self.rating = rating
        self.menu = menu
        self.imagesURL = imagesURL
    }
    
    func setReviews(reviews: [ModelReview]) {
        self.reviews = reviews
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
        cafeDic["rating"] = rating
        cafeDic["menu"] = menu
        cafeDic["imagesURL"] = imagesURL
        return cafeDic
    }

    func getReviews() -> [ModelReview] {
        return reviews
    }
    
    func setRating(rating: Double) {
        self.rating = rating
    }
}

class Cafe {
    static let sharedInstance = Cafe()
    var allCafeList = [ModelCafe]() {
        didSet {
            if self.allCafeList.count >= 500 {
                self.allCafeList.removeLast(150)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshMapMarkers"), object: nil)
            }
        }
    }
    var filterCafeList = [ModelCafe]()
    var bookmarkList = [ModelCafe]()
    var specificCafe = ModelCafe()
}
