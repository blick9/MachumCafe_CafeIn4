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
import Kingfisher

class NetworkUser {

    // MARK: 회원가입
    static func register(email: String, password: String, nickname: String, callback: @escaping (_ result: Bool) -> Void) {
        let parameters : Parameters = [
            "email" : email,
            "password" : password,
            "nickname" : nickname
        ]
        
        Alamofire.request("\(Config.url)/api/v1/user/register", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            let res = JSON(data: response.data!)
            let result = res["result"].boolValue
            callback(result)
        }
    }
    
    // MARK: 로그인
    static func logIn(email: String, password: String, callback: @escaping (_ result: Bool) -> Void) {
        let parameters : Parameters = [
            "email" : email,
            "password" : password
        ]
        
        Alamofire.request("\(Config.url)/api/v1/user/login", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success(let response):
                guard let contents = response as? [String:Any],
                    let result = contents["result"] as? Bool else { return }
                if result {
                    if let user = contents["user"] as? [String:Any],
                        let modelUser = ModelUser(JSON: user) {
                        User.sharedInstance.user = modelUser
                        User.sharedInstance.isUser = true
                    }
                }
                callback(result)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func kakaoLogin(email: String, nickname: String, imageURL: String) {
        let parameters : Parameters = [
            "email": email,
            "nickname": nickname,
            "imageURL": imageURL
        ]
        
        Alamofire.request("\(Config.url)/api/v1/user/login/kakao", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            
            switch response.result {
            case .success(let response):
                guard let contents = response as? [String:Any],
                    let user = contents["user"] as? [String:Any] else { return }
                if let modelUser = ModelUser(JSON: user) {
                    User.sharedInstance.user = modelUser
                    User.sharedInstance.isUser = true
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: 세션정보 있을 경우 유저모델 저장
    static func getUser() {
        Alamofire.request("\(Config.url)/api/v1/user/login").responseJSON { (response) in
            switch response.result {
            case .success(let response):
                guard let contents = response as? [String:Any],
                    let user = contents["user"] as? [String:Any] else { return }
                if let modelUser = ModelUser(JSON: user) {
                    User.sharedInstance.user = modelUser
                    User.sharedInstance.isUser = true
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: 로그아웃(세션 삭제)
    static func logout(callback: @escaping (_ description: String) -> Void) {
        Alamofire.request("\(Config.url)/api/v1/user/logout").responseJSON { (response) in
            let res = JSON(data: response.data!)
            callback(res["description"].stringValue)
        }
    }
    
    static func getUserImage(userID: String, isKakaoImage: Bool, imageURL: String) -> ImageResource {
        let profileImage = isKakaoImage ? ImageResource(downloadURL: URL(string: imageURL)!, cacheKey: imageURL) : ImageResource(downloadURL: URL(string:  "\(Config.url)/api/v1/user/\(userID)/profileimage/\(imageURL)")!, cacheKey: imageURL)
        return profileImage
    }
    
    static func setUserProfileImage(userID: String, image: UIImage, callback: @escaping (_ result: Bool) -> Void) {
        Alamofire.upload(multipartFormData: { multipartFormData in
            let imageData = UIImageJPEGRepresentation(image, 0.1)
            multipartFormData.append(imageData!, withName: "image", fileName: "file.png", mimeType: "image/png")
        }, to: "\(Config.url)/api/v1/user/\(userID)/profileimage", method: .put) { (res) in
            switch res {
            case .success(let upload, _, _):
                print("success")
                upload.responseJSON(completionHandler: { (response) in
                    let res = JSON(data: response.data!)
                    let result = res["result"].boolValue
                    if let user = res["user"].dictionary {
                        let imageURL = user["imageURL"]?.stringValue
                        let isKakaoImage = user["isKakaoImage"]?.boolValue
                        KingfisherManager.shared.cache.removeImage(forKey: imageURL!, fromDisk: true, completionHandler: nil)
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
