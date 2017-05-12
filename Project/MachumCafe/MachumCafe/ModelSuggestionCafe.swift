//
//  ModelSuggestionCafe.swift
//  MachumCafe
//
//  Created by HannaJeon on 2017. 5. 11..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import Foundation

class ModelSuggestionCafe {
    
    fileprivate var id : String?
    fileprivate var name : String?
    fileprivate var tel : String?
    fileprivate var address : String?
    fileprivate var hours : String?
    fileprivate var latitude : Double?
    fileprivate var longitude : Double?
    fileprivate var category : [String]?
    fileprivate var menu : String?
    fileprivate var imagesURL : [String]?
    fileprivate var imagesData : [Data]?
    
    init() {}
    
    init(id: String?, name: String?, tel: String?, address: String?, hours: String?, latitude: Double?, longitude: Double?, category: [String]?,  menu: String?, imagesURL: [String]?, imagesData: [Data]?) {
        self.id = id
        self.name = name
        self.tel = tel
        self.address = address
        self.hours = hours
        self.latitude = latitude
        self.longitude = longitude
        self.category = category
        self.menu = menu
        self.imagesURL = imagesURL
        self.imagesData = imagesData
    }
}

class SuggestionCafe {
    static let sharedInstance = SuggestionCafe()
    var suggestionNewCafe = [ModelSuggestionCafe]()
    var suggestionEditCafe = [ModelSuggestionCafe]()
}
