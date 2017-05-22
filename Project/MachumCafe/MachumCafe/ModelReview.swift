//
//  ModelReview.swift
//  MachumCafe
//
//  Created by   minjae on 2017. 5. 17..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class ModelReview {
    fileprivate var cafeId = String()
    fileprivate var userId = String()
    fileprivate var date = Date()
    fileprivate var reviewContent = String()
    fileprivate var rating = Double()
    //fileprivate var reviewImage = UIImage()
    
    init() {}
    
    init(cafeId : String, userId: String, date: Date, reviewContent: String, rating: Double) {
        self.cafeId = cafeId
        self.userId = userId
        self.date = date
        self.reviewContent = reviewContent
        self.rating = rating
    }
    
    func getReview() -> [String : Any] {
        var reviewDic = [String : Any]()
        reviewDic["cafeId"] = cafeId
        reviewDic["userId"] = userId
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
