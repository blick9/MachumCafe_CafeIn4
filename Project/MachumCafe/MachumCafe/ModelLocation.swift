//
//  ModelLocation.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 5. 6..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import Foundation

class ModelLocation {
    
    private(set) var latitude = Double()
    private(set) var longitude = Double()
    private(set) var address : String?
    
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
    
}

class Location {
    static let sharedInstance = Location()
    var currentLocation = ModelLocation() {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setLocation"), object: nil)
        }
    }
}
