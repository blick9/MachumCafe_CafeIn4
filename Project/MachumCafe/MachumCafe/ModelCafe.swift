//
//  ModelCafe.swift
//  MachumCafe
//
//  Created by HannaJeon on 2017. 4. 28..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import Foundation

class ModelCafe {
    
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
    
    func getParameters() -> [String:Any] {
        let paramerter: [String:Any] = [
            "id": id as Any,
            "name": name,
            "tel": tel as Any,
            "address": address,
            "hours": hours as Any,
            "latitude": latitude as Any,
            "longitude": longitude as Any,
            "category": category,
            "rating": rating,
            "menu": menu as Any,
            "imagesURL": imagesURL,
            "review": reviews
        ]
        return paramerter
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
