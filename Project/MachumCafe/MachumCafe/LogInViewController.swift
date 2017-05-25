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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .default
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


