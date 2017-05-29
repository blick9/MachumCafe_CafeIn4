//
//  LogInViewController.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 4. 25..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit
import Alamofire

class LogInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var kakaoLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .default
        kakaoLoginButton.addTarget(self, action: #selector(kakaoLogin), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
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
                    let email = user.email!
                    let nickname = user.property(forKey: "nickname") as! String
                    let imageURL = user.property(forKey: "profile_image") as! String

                    NetworkUser.kakaoLogin(email: email, nickname: nickname, imageURL: imageURL) { (result, user) in
                        let activityIndicator = UIActivityIndicatorView()
                        let startedIndicator = activityIndicator.showActivityIndicatory(view: self.view)
                        activityIndicator.stopActivityIndicator(view: self.view, currentIndicator: startedIndicator)
                        User.sharedInstance.user = user
                        User.sharedInstance.isUser = true
                        if !imageURL.isEmpty {
                            NetworkUser.getUserImage(userID: nil, isKakaoImage: user.getUser()["isKakaoImage"] as! Bool, imageURL: imageURL) { (imageData) in
                                user.setProfileImage(profileImage: imageData)
                                self.dismiss(animated: true, completion: nil)
                            }
                        } else {
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
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
                if !(user.getUser()["profileImageURL"] as! String).isEmpty {
                    NetworkUser.getUserImage(userID: user.getUser()["id"] as? String, isKakaoImage: user.getUser()["isKakaoImage"] as! Bool, imageURL: user.getUser()["profileImageURL"] as! String) { (imageData) in
                        user.setProfileImage(profileImage: imageData)
                        self.dismiss(animated: true, completion: nil)
                    }
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                UIAlertController().oneButtonAlert(target: self, title: "로그인", message: "아이디 또는 비밀번호를 다시 확인하세요.", isHandler: false)
            }
        }
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


