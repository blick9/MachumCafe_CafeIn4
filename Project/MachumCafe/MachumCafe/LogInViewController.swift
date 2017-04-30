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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func logInButton(_ sender: Any) {
        NetworkUser.logIn(email: emailTextField.text!, password: passwordTextField.text!) { (isUser) in
            if isUser == true {
                    let alert = UIAlertController(title: "Alert", message: "로그인!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                else {
                    let alert = UIAlertController(title: "Alert", message: "로그인 실패", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
        }
    }
}

    /*
    func loginreq (callback: @escaping (_ isUser : Bool) -> Void) {
        var isUser = Bool()
        let url = URL(string: "http://localhost:3000/api/v1/user/login")
        let parameters : Parameters = [
        "email" : self.emailTextField.text!,
        "password" : self.passwordTextField.text!
        ]
        
        Alamofire.request(url!, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            if let res = response.result.value as? [String : Any] {
                if let value = res["message"] as? Bool {
                    isUser = value
                }
            }
            callback(isUser)
        }
    }
     */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


