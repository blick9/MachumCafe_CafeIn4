//
//  SignUpViewController.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 4. 25..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit
import Alamofire

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var cofirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        
        if !nicknameTextField.hasText || !emailTextField.hasText || !passwordTextField.hasText {
            UIAlertController().oneButtonAlert(target: self, title: "회원가입", message: "빈칸을 채워주세요 :(", isHandler: false)
        } else if passwordTextField.text! != cofirmPasswordTextField.text! {
            UIAlertController().oneButtonAlert(target: self, title: "회원가입", message: "비밀번호가 일치하지 않습니다.", isHandler: false)
        } else if !(emailTextField.text?.isEmail)! {
            UIAlertController().oneButtonAlert(target: self, title: "회원가입", message: "올바른 이메일을 입력해주세요", isHandler: false)
        } else {
            NetworkUser.register(email: emailTextField.text!, password: passwordTextField.text!, nickname: nicknameTextField.text!) { (message) in
                if message {
                    UIAlertController().oneButtonAlert(target: self, title: "회원가입", message: "회원가입 완료 :)", isHandler: true)
                } else {
                    UIAlertController().oneButtonAlert(target: self, title: "회원가입", message: "이미 가입된 사용자입니다.", isHandler: false)
                }
            }
        }
    }
}

extension String {
    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: self)
    }
}


