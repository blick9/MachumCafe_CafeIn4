//
//  Cafe.swift
//  MachumCafe
//
//  Created by HannaJeon on 2017. 4. 27..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Kingfisher
import ObjectMapper

class NetworkCafe {
    
    // MARK: 현위치 반경 1km 내 카페목록 불러오기
    static func getCafeList(coordinate: ModelLocation, callback: @escaping (_ modelCafe: [ModelCafe]) -> Void) {
        let parameter: [String:Double] = [
            "latitude": coordinate.latitude,
            "longitude": coordinate.longitude
        ]
        
        Alamofire.request("\(Config.url)/api/v1/cafe", method: .post, parameters: parameter, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success(let response):
                guard let contents = response as? [[String:Any]] else { return }
                let cafes = Mapper<ModelCafe>().mapArray(JSONArray: contents)
                callback(cafes)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func getSpecificCafe(cafeId: String, callback: @escaping (_ modelCafe: ModelCafe) -> Void) {
        var modelCafe = ModelCafe()
        
        Alamofire.request("\(Config.url)/api/v1/cafe/\(cafeId)").responseJSON { (response) in
            var cafe = JSON(data: response.data!).dictionaryValue
            
            if let id = cafe["_id"]?.stringValue,
                let name = cafe["name"]?.stringValue,
                let address = cafe["address"]?.stringValue,
                let longitude = cafe["location"]?.arrayValue[0].doubleValue,
                let latitude = cafe["location"]?.arrayValue[1].doubleValue,
                let category = cafe["category"]?.arrayValue.map({ $0.stringValue }),
                let rating = cafe["rating"]?.doubleValue.roundToPlaces(places: 1),
                let imagesURL = cafe["imagesURL"]?.arrayValue.map({ $0.stringValue }) {
                let tel = cafe["tel"]?.stringValue
                let hours = cafe["hours"]?.stringValue
                let menu = cafe["menu"]?.stringValue
                modelCafe = ModelCafe(id: id, name: name, tel: tel, address: address, hours: hours, latitude: latitude, longitude: longitude, category: category, rating: rating, menu: menu, imagesURL: imagesURL)
            }
            callback(modelCafe)
        }
    }
    
    static func getCafeImage(imageURL: String) -> ImageResource {
        let cafeImage = ImageResource(downloadURL: URL(string: imageURL)!, cacheKey: imageURL)
        return cafeImage
    }
    
    static func postCafeReview(review: ModelReview, targetCafe: ModelCafe) {
        let cafeId = review.cafeId
        let parameter = review.toJSON()
        
        Alamofire.request("\(Config.url)/api/v1/cafe/\(cafeId)/review", method: .put, parameters: parameter, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success(let response):
                guard let contents = response as? [String:Any],
                    let result = contents["result"] as? Bool,
                    var rating = contents["rating"] as? Double else { return }
                if result {
                    targetCafe.setReviews(review: review)
                    targetCafe.setRating(rating: rating.roundToPlaces(places: 1))
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    static func getCafeReviews(cafeModel: ModelCafe, startIndex: Int=0) {
        guard let cafeId = cafeModel.id else { return }
        
        Alamofire.request("\(Config.url)/api/v1/cafe/\(cafeId)/review").responseJSON { (response) in
            switch response.result {
            case .success(let response):
//                var modelReviews = [ModelReview]()
                guard let contents = response as? [String:Any],
                    let reviews = contents["reviews"] as? [[String:Any]] else { return }
                let modelReviews = Mapper<ModelReview>().mapArray(JSONArray: reviews)
                cafeModel.setReviews(reviews: modelReviews.reversed())
//                reviews.forEach { review in
//                    if let modelReview = ModelReview(JSON: review) {
//                        modelReviews.insert(modelReview, at: 0)
//                    }
//                }
//                cafeModel.setReviews(reviews: modelReviews)
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}
