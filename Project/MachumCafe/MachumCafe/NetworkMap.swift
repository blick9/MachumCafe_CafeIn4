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

    static func getAddressFromCoordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees, callBack: @escaping ([String]) -> Void) {
        let addressURL = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(latitude),\(longitude)&language=ko&key=\(Config.googlePlaceKey)"
        
        Alamofire.request(addressURL).responseJSON { (response) in
            let json = JSON(data: response.data!)
            let result = json["results"].arrayValue

            if let _ = response.response?.statusCode {
                //예외 처리 해야함. 바다로 나갈 경우(formatted_address가 없을 경우) 런타임 에러
                let normalAddress = result[0]["formatted_address"].stringValue
                let roadNameAddress = result[1]["formatted_address"].stringValue
                callBack([normalAddress, roadNameAddress])
            }
        }
    }
}
