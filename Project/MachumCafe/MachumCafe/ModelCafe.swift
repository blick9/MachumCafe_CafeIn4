//
//  ModelCafe.swift
//  MachumCafe
//
//  Created by HannaJeon on 2017. 4. 28..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import Foundation

class ModelCafe {
    
    fileprivate var id = String()
    fileprivate var name = String()
    fileprivate var phoneNumber = String()
    fileprivate var address = String()
    fileprivate var hours = String()
    fileprivate var latitude = String()
    fileprivate var longitude = String()
    fileprivate var category = [String]()
    fileprivate var summary : String?
    fileprivate var mainMenu : [String]?
    
    init() {}
    
    init(id: String, name: String, phoneNumber: String, address: String, hours: String, latitude: String, longitude: String, category: [String], summary: String?, mainMenu: [String]?) {
        self.id = id
        self.name = name
        self.phoneNumber = phoneNumber
        self.address = address
        self.hours = hours
        self.latitude = latitude
        self.longitude = longitude
        self.category = category
        self.summary = summary
        self.mainMenu = mainMenu
    }
}

class Cafe {
    static let sharedInstance = Cafe()
    
    var cafeList = [ModelCafe]()
    var bookmarkList = [ModelCafe]()
}
