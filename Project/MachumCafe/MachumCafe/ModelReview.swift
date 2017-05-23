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
    fileprivate var cafeId = String()
    fileprivate var userId = String()
    fileprivate var nickname = String()
    fileprivate var date = String()
    fileprivate var reviewContent = String()
    fileprivate var rating = Double()
    //fileprivate var reviewImage = UIImage()
    
    init() {}
    
    init(id: String? = nil, cafeId : String, userId: String, nickname: String, date: String, reviewContent: String, rating: Double) {
        self.cafeId = cafeId
        self.userId = userId
        self.nickname = nickname
        self.date = date
        self.reviewContent = reviewContent
        self.rating = rating
    }
    
    func getReview() -> [String : Any] {
        var reviewDic = [String : Any]()
        reviewDic["cafeId"] = cafeId
        reviewDic["userId"] = userId
        reviewDic["nickname"] = nickname
        reviewDic["date"] = date
        reviewDic["reviewContent"] = reviewContent
        reviewDic["rating"] = rating
        return reviewDic
    }
}

class Review {
    static let sharedInstance = Review()
    var review = ModelReview()
}
