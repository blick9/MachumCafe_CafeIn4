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
    // MARK: 회원가입
    static func register(email: String, password: String, nickname: String, callback: @escaping (_ message: Bool) -> Void) {
        let url = URLpath.getURL()
        var message = Bool()
        
        let parameters : Parameters = [
            "email" : email,
            "password" : password,
            "nickname" : nickname
        ]
        
        Alamofire.request("\(url)/api/v1/user/register", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            if let res = response.result.value as? [String : Any] {
                if let resMessage = res["message"] as? Bool {
                    message = resMessage
                }
            }
            callback(message)
        }
    }
    
    // MARK: 로그인
    static func logIn(email: String, password: String, callback: @escaping (_ message: Bool, _ user: ModelUser) -> Void) {
        let url = URLpath.getURL()
        var message = Bool()
        var user = ModelUser()
        
        let parameters : Parameters = [
            "email" : email,
            "password" : password
        ]
        
        Alamofire.request("\(url)/api/v1/user/login", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            if let res = response.result.value as? [String : Any] {
                if let resMessage = res["message"] as? Bool {
                    message = resMessage
                }
                if let resUser = res["user"] as? [String : Any] {
                    if let id = resUser["_id"] as? String,
                    let email = resUser["email"] as? String,
                    let nickname = resUser["nickname"] as? String,
                    let bookmark = resUser["bookmark"] as? [String] {
                        let modelUser = ModelUser(id: id, email: email, nickname: nickname, bookmark: bookmark)
                        user = modelUser
                    }
                }
            }
            callback(message, user)
        }
    }
    
    // MARK: 세션정보 있을 경우 유저모델 저장
    static func getUser(callback: @escaping (_ message: Bool, _ user: ModelUser) -> Void) {
        let url = URLpath.getURL()
        var message = Bool()
        var user = ModelUser()
        
        Alamofire.request("\(url)/api/v1/user/login").responseJSON { (response) in
            if let res = response.result.value as? [String : Any] {
                if let resMessage = res["message"] as? Bool {
                    message = resMessage
                }
                if let resUser = res["user"] as? [String : Any] {
                    if let id = resUser["_id"] as? String,
                    let email = resUser["email"] as? String,
                    let nickname = resUser["nickname"] as? String,
                    let bookmark = resUser["bookmark"] as? [String] {
                        let modelUser = ModelUser(id: id, email: email, nickname: nickname, bookmark: bookmark)
                        user = modelUser
                    }
                }
            }
            callback(message, user)
        }
    }
    
}
