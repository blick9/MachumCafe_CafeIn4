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
                let isKakaoImage = user["isKakaoImage"]?.boolValue,
                let email = user["email"]?.stringValue,
                let nickname = user["nickname"]?.stringValue,
                let bookmark = user["bookmark"]?.arrayValue.map({ $0.stringValue }) {
                    var imageURL = String()
                    if let userImageURL = user["imageURL"]?.stringValue {
                        imageURL = userImageURL
                    }
                    modelUser = ModelUser(id: id, isKakaoImage: isKakaoImage, email: email, nickname: nickname, bookmark: bookmark, profileImageURL: imageURL)
                }
            }
            callback(result, modelUser)
        }
    }
    
    static func kakaoLogin(email: String, nickname: String, imageURL: String, callback: @escaping (_ result: Bool, _ modelUser: ModelUser) -> Void) {
        let parameters : Parameters = [
            "email": email,
            "nickname": nickname,
            "imageURL": imageURL
        ]
        
        Alamofire.request("\(url)/api/v1/user/login/kakao", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            var modelUser = ModelUser()
            let res = JSON(data: response.data!)
            let result = res["result"].boolValue
            if let user = res["user"].dictionary {
                if let id = user["_id"]?.stringValue,
                let isKakaoImage = user["isKakaoImage"]?.boolValue,
                let email = user["email"]?.stringValue,
                let nickname = user["nickname"]?.stringValue,
                let bookmark = user["bookmark"]?.arrayValue.map({ $0.stringValue }) {
                    var imageURL = String()
                    if let userImageURL = user["imageURL"]?.stringValue {
                        imageURL = userImageURL
                    }
                    modelUser = ModelUser(id: id, isKakaoImage: isKakaoImage, email: email, nickname: nickname, bookmark: bookmark, profileImageURL: imageURL)
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
                let isKakaoImage = user["isKakaoImage"]?.boolValue,
                let nickname = user["nickname"]?.stringValue,
                let bookmark = user["bookmark"]?.arrayValue.map({ $0.stringValue }) {
                    var imageURL = String()
                    if let userImageURL = user["imageURL"]?.stringValue {
                        imageURL = userImageURL
                    }
                    modelUser = ModelUser(id: id, isKakaoImage: isKakaoImage, email: email, nickname: nickname, bookmark: bookmark, profileImageURL: imageURL
                    )
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
    
    static func getUserImage(userID: String?, isKakaoImage: Bool, imageURL: String, callback: @escaping (_ imageData: Data) -> Void) {
        if isKakaoImage {
            Alamofire.request(imageURL).responseData { (response) in
                if let imageData = response.result.value {
                    callback(imageData)
                }
            }
        } else {
            Alamofire.request("\(url)/api/v1/user/\(userID!)/profileimage/\(imageURL)").responseData { (response) in
                if let imageData = response.result.value {
                    callback(imageData)
                }
            }
        }
    }
    
    static func setUserProfileImage(userID: String, image: UIImage, callback: @escaping (_ result: Bool) -> Void) {
        Alamofire.upload(multipartFormData: { multipartFormData in
            let imageData = UIImageJPEGRepresentation(image, 0.1)
            multipartFormData.append(imageData!, withName: "image", fileName: "file.png", mimeType: "image/png")
        }, to: "\(url)/api/v1/user/\(userID)/profileimage", method: .put) { (res) in
            switch res {
            case .success(let upload, _, _):
                print("success")
                upload.responseJSON(completionHandler: { (response) in
                    let res = JSON(data: response.data!)
                    let result = res["result"].boolValue
                    if let user = res["user"].dictionary {
                        let imageURL = user["imageURL"]?.stringValue
                        let isKakaoImage = user["isKakaoImage"]?.boolValue
                        User.sharedInstance.user.setProfileImageURL(imageURL: imageURL!, isKakaoImage: isKakaoImage!)
                    }
                    callback(result)
                })
            case .failure(let error):
                print("failed")
                print(error)
            }
        }
    }
}
