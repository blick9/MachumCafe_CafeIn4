//
//  NetworkMap.swift
//  MachumCafe
//
//  Created by HannaJeon on 2017. 5. 3..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import Foundation
import GoogleMaps
import Alamofire
import SwiftyJSON

class NetworkMap {
    
    private static let mapKey = "AIzaSyBNTjHJ-wYRN_p9x7HMJu-_sI2LG-kzVj4"
    
    // MARK: 내 주위 700미터 안의 카페 탐색
    static func searchCafeAroundMe(latitude: CLLocationDegrees, longitude: CLLocationDegrees, callback: @escaping ([[String : Any]]) -> Void) {
        
        var cafeInfo = [String : Any]()
        var cafeInfoArray = [[String : Any]]()
        let aroundMeURL = "https://maps.googleapis.com/maps/api/place/radarsearch/json?location=\(latitude),\(longitude)&radius=700&type=cafe&key=\(mapKey)"
        
        Alamofire.request(aroundMeURL).responseJSON { (response) in
            let json = JSON(data: response.data!)
            let results = json["results"].arrayValue
            
            for result in results {
                let geometry = result["geometry"].dictionaryValue
                let location = geometry["location"]?.dictionary
                let cafeLatitude = location?["lat"]?.doubleValue
                let cafeLongitude = location?["lng"]?.doubleValue
                let cafeInfoId = result["place_id"].stringValue
                
                cafeInfo["cafeLatitude"] = cafeLatitude
                cafeInfo["cafeLongitude"] = cafeLongitude
                cafeInfo["cafeInfoId"] = cafeInfoId
                cafeInfoArray.append(cafeInfo)
            }
            callback(cafeInfoArray)
        }
    }
    
    // Mark: 마커 뿌리기
    static func spreadMarker(cafeInfoArray: [[String : Any]], callback: @escaping (_ cafeInfo: [String: Any], _ name: String, _ address: String) -> Void) {
        for cafeInfo in cafeInfoArray {
            let cafeURL = "https://maps.googleapis.com/maps/api/place/details/json?placeid=\(cafeInfo["cafeInfoId"]!)&language=ko&key=\(mapKey)"
            
            Alamofire.request(cafeURL).responseJSON(completionHandler: { (response) in
                let json = JSON(data: response.data!)
                let result = json["result"].dictionary
                let address = result?["formatted_address"]?.stringValue
                let name = result?["name"]?.stringValue
                callback(cafeInfo, name!, address!)
            })
        }
    }
    
    static func getAddressFromCoordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees, callBack: @escaping ([String]) -> Void) {
        let addressURL = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(latitude),\(longitude)&language=ko&key=\(mapKey)"
        
        Alamofire.request(addressURL).responseJSON { (response) in
            let json = JSON(data: response.data!)
            let result = json["results"].arrayValue

            if let value = response.response?.statusCode {
                //예외 처리 해야함. 바다로 나갈 경우(formatted_address가 없을 경우) 런타임 에러
                let normalAddress = result[0]["formatted_address"].stringValue
                let roadNameAddress = result[1]["formatted_address"].stringValue
                callBack([normalAddress, roadNameAddress])
            }
        }
    }
}
