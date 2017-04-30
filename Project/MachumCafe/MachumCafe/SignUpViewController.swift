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
        // Do any additional setup after loading the view.
        NetworkBookmark.getMyBookmark(userId: User.sharedInstance.user.id)
        print(Cafe.sharedInstance.bookmarkList)
        dump(Cafe.sharedInstance.bookmarkList)
        print(Cafe.sharedInstance.bookmarkList.count)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        print(Cafe.sharedInstance.bookmarkList)
        dump(Cafe.sharedInstance.bookmarkList)
        print(Cafe.sharedInstance.bookmarkList.count)
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        registerReq { (isUser) in
            if isUser == true {
                let alert = UIAlertController(title: "Alert", message: "회원가입 완료!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else {
                let alert = UIAlertController(title: "Alert", message: "이미 가입된 사용자입니다.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    
    func registerReq (callback : @escaping (_ isUser : Bool) -> Void) {
        var isUser = Bool()
        let url = URL(string: "http://localhost:3000/api/v1/user/register")
        let parameters : Parameters = [
            "email" : self.emailTextField.text!,
            "password" : self.passwordTextField.text!
        ]
        Alamofire.request(url!, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            if let res = response.result.value as? [String : Any ] {
                print("response",res)
                if let value = res["message"] as? Bool {
                    isUser = value
                }
            }
            callback(isUser)
        }
    
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
