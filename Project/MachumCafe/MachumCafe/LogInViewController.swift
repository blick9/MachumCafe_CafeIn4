//
//  LogInViewController.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 4. 25..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit
import Alamofire

class LogInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var kakaoLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .default
        kakaoLoginButton.addTarget(self, action: #selector(kakaoLogin), for: .touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func kakaoLogin() {
        let session = KOSession.shared()
        if (session?.isOpen())! {
            session?.close()
        }
        session?.presentingViewController = self
        session?.open(completionHandler: { (error) in
            if (session?.isOpen())! {
                KOSessionTask.meTask(completionHandler: { (profile, error) in
                    let user = profile as! KOUser
                    let id = String(describing: user.id)
                    let email = user.email!
                    let nickname = user.property(forKey: "nickname") as! String
                    let imageUrl = user.property(forKey: "profile_image")
                    var profileImage = Data()
                    NetworkUser.getUserImage(imageUrl: imageUrl as! String, callback: { (imageData) in
                        profileImage = imageData
                        User.sharedInstance.user = ModelUser(id: id, email: email, nickname: nickname, bookmark: [String](), profileImage: profileImage)
                        User.sharedInstance.isUser = true
                        KOSessionTask.accessTokenInfoTask(completionHandler: { (accessTokenInfo, error) in
                        })
                        self.dismiss(animated: true, completion: nil)
                    })
                })
            }
        })
    }
    
     @IBAction func logInButton(_ sender: Any) {
        let activityIndicator = UIActivityIndicatorView()
        let startedIndicator = activityIndicator.showActivityIndicatory(view: self.view)
        NetworkUser.logIn(email: emailTextField.text!, password: passwordTextField.text!) { (result, user) in
            activityIndicator.stopActivityIndicator(view: self.view, currentIndicator: startedIndicator)
            if result {
                User.sharedInstance.user = user
                User.sharedInstance.isUser = true
                self.dismiss(animated: true, completion: nil)
            } else {
                UIAlertController().oneButtonAlert(target: self, title: "로그인", message: "아이디 또는 비밀번호를 다시 확인하세요.", isHandler: false)
            }
        }
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


