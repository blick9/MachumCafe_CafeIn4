//
//  ModelReview.swift
//  MachumCafe
//
//  Created by   minjae on 2017. 5. 17..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class ModelReview {
    fileprivate var id : String?
    fileprivate var isKakao = Bool()
    fileprivate var cafeId = String()
    fileprivate var userId = String()
    fileprivate var nickname = String()
    fileprivate var profileImageURL : String?
    fileprivate var profileImage : Data?
    fileprivate var date = String()
    fileprivate var reviewContent = String()
    fileprivate var rating = Double()
    
    init() {}
    
    init(id: String? = nil, isKakao: Bool, cafeId : String, userId: String, nickname: String, profileImageURL: String? = nil, date: String, reviewContent: String, rating: Double) {
        self.cafeId = cafeId
        self.isKakao = isKakao
        self.userId = userId
        self.nickname = nickname
        self.profileImageURL = profileImageURL
        self.date = date
        self.reviewContent = reviewContent
        self.rating = rating
    }
    
    func getReview() -> [String : Any] {
        var reviewDic = [String : Any]()
        reviewDic["cafeId"] = cafeId
        reviewDic["isKakao"] = isKakao
        reviewDic["userId"] = userId
        reviewDic["nickname"] = nickname
        reviewDic["profileImageURL"] = profileImageURL
        reviewDic["profileImage"] = profileImage
        reviewDic["date"] = date
        reviewDic["reviewContent"] = reviewContent
        reviewDic["rating"] = rating
        return reviewDic
    }
    
    func setProfileImage(profileImage: Data) {
        self.profileImage = profileImage
    }
}

class Review {
    static let sharedInstance = Review()
    var review = ModelReview()
}
