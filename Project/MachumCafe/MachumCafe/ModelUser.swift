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
    fileprivate var email = String()
    fileprivate var nickname = String()
    fileprivate var bookmark = [String]()
    fileprivate var imageURL : String?
    fileprivate var profileImage = Data()
    
    init() {}
    
    init(id: String, email: String, nickname: String, bookmark: [String], imageURL: String? = nil) {
        self.id = id
        self.email = email
        self.nickname = nickname
        self.bookmark = bookmark
        self.imageURL = imageURL
        self.profileImage = Data()
    }
    
    func getUser() -> [String : Any] {
        var userDic = [String : Any]()
        userDic["id"] = id
        userDic["email"] = email
        userDic["nickname"] = nickname
        userDic["bookmark"] = bookmark
        userDic["imageURL"] = imageURL
        userDic["profileImage"] = profileImage
        return userDic
    }
    
    func setProfileImage(profileImage: Data) {
        self.profileImage = profileImage
    }
    
    func setBookmark(bookmarks : [String]) {
        bookmark = bookmarks
    }
    
}

class User {
    static let sharedInstance = User()
    var isUser = Bool()
    var user = ModelUser()
}
