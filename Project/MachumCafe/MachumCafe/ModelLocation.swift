//
//  ModelLocation.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 5. 6..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import Foundation

class ModelLocation {
    
    private var latitude = Double()
    private var longitude = Double()
    private var address : String?
    
    init() {}
    
    init(latitude: Double, longitude: Double, address: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
    }
    
    func setLocation(latitude: Double, longitude: Double, address: String?) {
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
    }
    
    func getLocation() -> [String : Any] {
        var locationDic = [String : Any]()
        locationDic["latitude"] = latitude
        locationDic["longitude"] = longitude
        locationDic["address"] = address
        return locationDic
    }
}

class Location {
    static let sharedInstance = Location()
    var currentLocation = ModelLocation() {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setLocation"), object: nil)
        }
    }
}
