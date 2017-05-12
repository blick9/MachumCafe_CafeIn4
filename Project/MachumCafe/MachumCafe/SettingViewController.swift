//
//  SettingViewController.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 5. 2..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var logOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "설정"
        logOutButton.tintColor = UIColor.red
        
        checkLogin()
    }
    
    func checkLogin() {
        logOutButton.isHidden = User.sharedInstance.isUser ? false : true
    }
    
    @IBAction func logOutButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: "로그아웃", message: "로그아웃 하시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "CANCEL", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            NetworkUser.logout { (des) in
                User.sharedInstance.user = ModelUser()
                User.sharedInstance.isUser = false
                self.dismiss(animated: true, completion: nil)
                print(des, "\n로그아웃!")
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
