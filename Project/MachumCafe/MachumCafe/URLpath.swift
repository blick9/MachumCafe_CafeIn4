//
//  URLpath.swift
//  MachumCafe
//
//  Created by HannaJeon on 2017. 4. 28..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import Foundation

class URLpath {
    static func getURL() -> String {
        let filePath = Bundle.main.path(forResource: "Info", ofType: "plist")
        let info = NSDictionary(contentsOfFile: filePath!)
        let url = info?["URL"] as! String
        
        return url   
    }
}
