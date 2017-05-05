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
        logOutButton.tintColor = UIColor.red

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logOutButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: "로그아웃", message: "로그아웃 하시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "CANCEL", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            // MARK: 2. 이거 활성화 하면 로그아웃 하고 dismiss됐을 때 닉네임 보임... 해결좀 ㅋㅋㅋ
            NetworkUser.logout { (des) in
                User.sharedInstance.user = ModelUser()
                User.sharedInstance.isUser = false
                print(des)
                print("로그아웃!")
            }
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)

        // MARK: 1. 이거 활성하하고 하면 로그아웃 하고 나갔을때 바로 로그인 버튼 보이는데
//        NetworkUser.logout { (des) in
//            User.sharedInstance.user = ModelUser()
//            User.sharedInstance.isUser = false
//            print(des)
//        }
    }
    
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
