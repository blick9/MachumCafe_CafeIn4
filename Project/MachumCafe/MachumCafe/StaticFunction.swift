//
//  StaticFunction.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 5. 2..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit
import Foundation

extension UIAlertController {
    func presentSuggestionLogInAlert(target : UIViewController, title : String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "닫기", style: .default) { _ in
            target.dismiss(animated: true, completion: nil)
        }
        let logInAction = UIAlertAction(title: "로그인", style: .default) { _ in
            let logInStoryboard = UIStoryboard(name: "LogIn&SignUpView", bundle: nil)
            let logInViewController = logInStoryboard.instantiateViewController(withIdentifier: "LogIn")
            target.present(logInViewController, animated: true, completion: nil)
            
        }
        alertController.addAction(okAction)
        alertController.addAction(logInAction)
        target.present(alertController, animated: true, completion: nil)
    }
}
