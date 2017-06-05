//
//  SignUpViewController.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 4. 25..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit
import Alamofire

class SignUpViewController: UIViewController, UITextFieldDelegate{
    
    var textFieldArray = [UITextField]()
    
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var cofirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        self.textFieldArray = [nicknameTextField,emailTextField,passwordTextField,cofirmPasswordTextField]
        for textfield in textFieldArray{
            textfield.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for textfield in textFieldArray{
            textfield.resignFirstResponder()
        }
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if self.view.frame.origin.y == 0{
            self.view.frame.origin.y -= 125
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
            if self.view.frame.origin.y != 0{
            self.view.frame.origin.y += 125
        }
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
        } else if !(passwordTextField.text?.isPassword)! {
            UIAlertController().oneButtonAlert(target: self, title: "회원가입", message: "비밀번호는 6자리 이상 입력 해주세요.", isHandler: false)
        } else if !(emailTextField.text?.isEmail)! {
            UIAlertController().oneButtonAlert(target: self, title: "회원가입", message: "올바른 이메일을 입력해주세요", isHandler: false)
        } else {
            NetworkUser.register(email: emailTextField.text!, password: passwordTextField.text!, nickname: nicknameTextField.text!) { (result) in
                if result {
                    UIAlertController().oneButtonAlert(target: self, title: "회원가입", message: "회원가입 완료 :)", isHandler: true)
                } else {
                    UIAlertController().oneButtonAlert(target: self, title: "회원가입", message: "이미 가입된 사용자입니다.", isHandler: false)
                }
            }
        }
    }
}


