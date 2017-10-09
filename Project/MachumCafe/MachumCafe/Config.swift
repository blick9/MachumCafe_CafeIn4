//
//  Config.swift
//  MachumCafe
//
//  Created by HannaJeon on 2017. 9. 27..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import Foundation

struct Config {
    static private let plist: NSDictionary? = {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
            let plist = NSDictionary(contentsOfFile: path) else { return nil }
        return plist
    }()
    
    static let googleMapKey: String = {
        plist?["googleMapKey"] as? String ?? ""
    }()
    
    static let googlePlaceKey: String = {
        plist?["googlePlaceKey"] as? String ?? ""
    }()
    
    static let url: String = {
        plist?["URL"] as? String ?? ""
    }()
}
