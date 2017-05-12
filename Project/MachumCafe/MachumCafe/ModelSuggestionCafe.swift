//
//  ModelSuggestionCafe.swift
//  MachumCafe
//
//  Created by HannaJeon on 2017. 5. 11..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import Foundation

class ModelSuggestionCafe {
    
    fileprivate var name : String?
    fileprivate var tel : String?
    fileprivate var address : String?
    fileprivate var hours : String?
    fileprivate var category : [String]?
    fileprivate var menu : String?
    fileprivate var imagesData : [Data]?
    
    init() {}
    
    init(name: String, tel: String, address: String, hours: String, category: [String], menu: String, imagesData: [Data]) {
        self.name = name
        self.tel = tel
        self.address = address
        self.hours = hours
        self.category = category
        self.menu = menu
        self.imagesData = imagesData
    }
}

class SuggestionCafe {
    static let sharedInstance = SuggestionCafe()
    var suggestionCafe = [ModelSuggestionCafe]()
}
