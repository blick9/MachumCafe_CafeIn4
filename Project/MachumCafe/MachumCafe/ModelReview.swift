//
//  ModelReview.swift
//  MachumCafe
//
//  Created by   minjae on 2017. 5. 17..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit
import ObjectMapper

class ModelReview: Mappable {
    private(set) var id: String?
    private(set) var isKakaoImage = Bool()
    private(set) var cafeId = String()
    private(set) var userId = String()
    private(set) var nickname = String()
    private(set) var profileImageURL: String?
    private(set) var profileImage: Data?
    private(set) var date = String()
    private(set) var reviewContent = String()
    private(set) var rating = Double()
    
    required init?(map: Map) {
    }
    
    init() {
    }
    
    func mapping(map: Map) {
        id <- map["_id"]
        isKakaoImage <- map["isKakaoImage"]
        cafeId <- map["cafeId"]
        userId <- map["userId"]
        nickname <- map["nickname"]
        profileImageURL <- map["profileImageURL"]
        date <- map["date"]
        reviewContent <- map["reviewContent"]
        rating <- map["rating"]
    }
    
    init(id: String? = nil, isKakaoImage: Bool, cafeId : String, userId: String, nickname: String, profileImageURL: String?=nil, date: String, reviewContent: String, rating: Double) {
        self.cafeId = cafeId
        self.isKakaoImage = isKakaoImage
        self.userId = userId
        self.nickname = nickname
        self.profileImageURL = profileImageURL
        self.date = date
        self.reviewContent = reviewContent
        self.rating = rating
    }
    
    func setProfileImage(profileImage: Data) {
        self.profileImage = profileImage
    }
}

class Review {
    static let sharedInstance = Review()
    var review = ModelReview()
}
