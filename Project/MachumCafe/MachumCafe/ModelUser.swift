//
//  UserModel.swift
//  MachumCafe
//
//  Created by HannaJeon on 2017. 4. 27..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import Foundation

class ModelUser {
    
    private var id = String()
    private var isKakaoImage = Bool()
    private var email = String()
    private var nickname = String()
    private var bookmark = [String]()
    private var profileImageURL = String()
    
    init() {}
    
    init(id: String, isKakaoImage: Bool, email: String, nickname: String, bookmark: [String], profileImageURL: String) {
        self.id = id
        self.isKakaoImage = isKakaoImage
        self.email = email
        self.nickname = nickname
        self.bookmark = bookmark
        self.profileImageURL = profileImageURL
    }
    
    func getUser() -> [String : Any] {
        var userDic = [String : Any]()
        userDic["id"] = id
        userDic["isKakaoImage"] = isKakaoImage
        userDic["email"] = email
        userDic["nickname"] = nickname
        userDic["bookmark"] = bookmark
        userDic["profileImageURL"] = profileImageURL
        return userDic
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
