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
    fileprivate var review = String()
    fileprivate var date = Date()
    fileprivate var rating = Double()
    //fileprivate var reviewImage = UIImage()
    
    
    init() {}
    
    init(cafeId : String, userId: String, review: String, date: Date, rating: Double) {
        self.cafeId = cafeId
        self.userId = userId
        self.review = review
        self.date = date
        self.rating = rating
    }
    
    func getReview() -> [String : Any] {
        var reviewDic = [String:Any]()
        reviewDic["careId"] = cafeId
        reviewDic["userId"] = userId
        reviewDic["review"] = review
        reviewDic["date"] = date
        reviewDic["rating"] = rating
        return reviewDic
    }
    
}

class Review {
    static let sharedInstance = Review()
    var review = ModelReview()
}
