//
//  ModelCafe.swift
//  MachumCafe
//
//  Created by HannaJeon on 2017. 4. 28..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import Foundation
import ObjectMapper

class ModelCafe: Mappable {
    private(set) var id : String?
    private(set) var name = String()
    private(set) var tel : String?
    private(set) var address = String()
    private(set) var hours : String?
    private(set) var latitude : Double?
    private(set) var longitude : Double?
    private(set) var category = [String]()
    private(set) var rating = Double()
    private(set) var menu : String?
    private(set) var imagesURL = [String]()
    private(set) var reviews = [ModelReview]() {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshReview"), object: nil)
        }
    }
    
    required init?(map: Map) {
    }
    
    init() {
    }
        
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
    
    func mapping(map: Map) {
        self.id <- map["_id"]
        self.name <- map["name"]
        self.tel <- map["tel"]
        self.address <- map["address"]
        self.hours <- map["hours"]
        self.latitude <- map["location.1"]
        self.longitude <- map["location.0"]
        self.category <- map["category"]
        self.rating <- map["rating"]
        self.menu <- map["manu"]
        self.imagesURL <- map["imagesURL"]
    }
    
    func setReviews(reviews: [ModelReview]?=nil, review: ModelReview?=nil) {
        if let reviews = reviews {
            self.reviews = reviews
        } else if let review = review {
            self.reviews.insert(review, at: 0)
        }
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
