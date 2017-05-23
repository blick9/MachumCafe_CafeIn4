//
//  User.swift
//  MachumCafe
//
//  Created by HannaJeon on 2017. 4. 27..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkUser {
    
    private static let url = URLpath.getURL()

    // MARK: 회원가입
    static func register(email: String, password: String, nickname: String, callback: @escaping (_ result: Bool) -> Void) {
        let parameters : Parameters = [
            "email" : email,
            "password" : password,
            "nickname" : nickname
        ]
        
        Alamofire.request("\(url)/api/v1/user/register", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            let res = JSON(data: response.data!)
            let result = res["result"].boolValue
            callback(result)
        }
    }
    
    // MARK: 로그인
    static func logIn(email: String, password: String, callback: @escaping (_ result: Bool, _ modelUser: ModelUser) -> Void) {
        let parameters : Parameters = [
            "email" : email,
            "password" : password
        ]
        
        Alamofire.request("\(url)/api/v1/user/login", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            var modelUser = ModelUser()
            let res = JSON(data: response.data!)
            let result = res["result"].boolValue
            if let user = res["user"].dictionary {
                if let id = user["_id"]?.stringValue,
                let email = user["email"]?.stringValue,
                let nickname = user["nickname"]?.stringValue,
                let bookmark = user["bookmark"]?.arrayValue.map({ $0.stringValue }) {
                    modelUser = ModelUser(id: id, email: email, nickname: nickname, bookmark: bookmark)
                }
            }
            callback(result, modelUser)
        }
    }
    
    // MARK: 세션정보 있을 경우 유저모델 저장
    static func getUser(callback: @escaping (_ result: Bool, _ modelUser: ModelUser) -> Void) {
        Alamofire.request("\(url)/api/v1/user/login").responseJSON { (response) in
            var modelUser = ModelUser()

            let res = JSON(data: response.data!)
            let result = res["result"].boolValue
            if let user = res["user"].dictionary {
                if let id = user["_id"]?.stringValue,
                let email = user["email"]?.stringValue,
                let nickname = user["nickname"]?.stringValue,
                let bookmark = user["bookmark"]?.arrayValue.map({ $0.stringValue }) {
                    modelUser = ModelUser(id: id, email: email, nickname: nickname, bookmark: bookmark)
                }
            }
            callback(result, modelUser)
        }
    }
    
    // MARK: 로그아웃(세션 삭제)
    static func logout(callback: @escaping (_ description: String) -> Void) {
        Alamofire.request("\(url)/api/v1/user/logout").responseJSON { (response) in
            let res = JSON(data: response.data!)
            callback(res["description"].stringValue)
        }
    }
    
    static func getUserImage(imageUrl: String, callback: @escaping (_ imageData: Data) -> Void) {
        Alamofire.request(imageUrl).responseData { (response) in
            if let imageData = response.result.value {
                callback(imageData)
            }
        }
    }
    
}
