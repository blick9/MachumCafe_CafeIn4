//
//  UserModel.swift
//  MachumCafe
//
//  Created by HannaJeon on 2017. 4. 27..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import Foundation

class ModelUser {
    
    var id = String()
    fileprivate var email = String()
    fileprivate var nickname = String()
    fileprivate var bookmark = [String]()
    
    init() {}
    
    init(id: String, email: String, nickname: String, bookmark: [String]) {
        self.id = id
        self.email = email
        self.nickname = nickname
        self.bookmark = bookmark
    }
}

class User {
    static let sharedInstance = User()
    
    var user = ModelUser()
}
