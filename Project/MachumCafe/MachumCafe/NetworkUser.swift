//
//  User.swift
//  MachumCafe
//
//  Created by HannaJeon on 2017. 4. 27..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import Foundation
import Alamofire

class NetworkUser {
    // 회원가입
    static func register(email: String, password: String, nickname: String, callback: @escaping (_ isUser: Bool) -> Void) {
        let url = URLpath.getURL()
        var isUser = Bool()
        let parameters : Parameters = [
            "email" : email,
            "password" : password,
            "nickname" : nickname
        ]
        
        Alamofire.request("\(url)/api/v1/user/register", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            if let res = response.result.value as? [String : Any] {
                if let message = res["message"] as? Bool {
                    isUser = message
                }
            }
            callback(isUser)
        }
    }
    
    // 로그인
    static func logIn(email: String, password: String, callback: @escaping (_ isUser: Bool) -> Void) {
        let url = URLpath.getURL()
        var isUser = Bool()
        let parameters : Parameters = [
            "email" : email,
            "password" : password
        ]
        
        Alamofire.request("\(url)/api/v1/user/login", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            if let res = response.result.value as? [String : Any] {
                if let message = res["message"] as? Bool {
                    isUser = message
                }
                if let user = res["user"] as? [String : Any] {
                    if let id = user["_id"] as? String,
                    let email = user["email"] as? String,
                    let nickname = user["nickname"] as? String,
                    let bookmark = user["bookmark"] as? [String] {
                        let modelUser = ModelUser(id: id, email: email, nickname: nickname, bookmark: bookmark)
                        User.sharedInstance.user = modelUser
                    }
                }
            }
            callback(isUser)
        }
    }
    
}
