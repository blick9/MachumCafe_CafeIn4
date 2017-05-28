//
//  UserModel.swift
//  MachumCafe
//
//  Created by HannaJeon on 2017. 4. 27..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import Foundation

class ModelUser {
    
    fileprivate var id = String()
    fileprivate var isKakaoImage = Bool()
    fileprivate var email = String()
    fileprivate var nickname = String()
    fileprivate var bookmark = [String]()
    fileprivate var profileImageURL : String?
    fileprivate var profileImage = Data()
    
    init() {}
    
    init(id: String, isKakaoImage: Bool, email: String, nickname: String, bookmark: [String], profileImageURL: String? = nil) {
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
        userDic["profileImage"] = profileImage
        return userDic
    }
    
    func setBookmark(bookmarks : [String]) {
        bookmark = bookmarks
    }
    
    func setProfileImage(profileImage: Data) {
        self.profileImage = profileImage
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
