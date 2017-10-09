//
//  UserModel.swift
//  MachumCafe
//
//  Created by HannaJeon on 2017. 4. 27..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import Foundation
import ObjectMapper

class ModelUser: Mappable {
    private(set) var id = String()
    private(set) var isKakaoImage = Bool()
    private(set) var email = String()
    private(set) var nickname = String()
    private(set) var bookmark = [String]()
    private(set) var profileImageURL = String()
    
    required init?(map: Map) {
    }
    
    init() {
    }
    
    func mapping(map: Map) {
        self.id <- map["_id"]
        self.isKakaoImage <- map["isKakaoImgae"]
        self.email <- map["email"]
        self.nickname <- map["nickname"]
        self.bookmark <- map["bookmark"]
        self.profileImageURL <- map["imageURL"]
    }
    
    func setBookmark(bookmarks : [String]) {
        bookmark = bookmarks
    }
    
    func setProfileImageURL(imageURL: String, isKakaoImage: Bool) {
        self.profileImageURL = imageURL
        self.isKakaoImage = isKakaoImage
    }
    
}

class User {
    static let sharedInstance = User()
    var isUser = Bool() {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "checkIsUser"), object: nil)
        }
    }
    var user = ModelUser()
}
