//
//  ModelReview.swift
//  MachumCafe
//
//  Created by   minjae on 2017. 5. 17..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class ModelReview {
    
    private(set) var id : String?
    private(set) var isKakaoImage = Bool()
    private(set) var cafeId = String()
    private(set) var userId = String()
    private(set) var nickname = String()
    private(set) var profileImageURL : String!
    private(set) var profileImage : Data?
    private(set) var date = String()
    private(set) var reviewContent = String()
    private(set) var rating = Double()
    
    init() {}
    
    init(id: String? = nil, isKakaoImage: Bool, cafeId : String, userId: String, nickname: String, profileImageURL: String? = nil, date: String, reviewContent: String, rating: Double) {
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
