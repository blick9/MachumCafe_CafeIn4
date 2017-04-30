//
//  MainSideBarViewController.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 4. 25..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class MainSideBarViewController: UIViewController {
    @IBOutlet weak var sideBarView: UIView!
    @IBOutlet weak var sideBarLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.keyWindow?.windowLevel = (UIWindowLevelStatusBar + 1)
        sideBarLeadingConstraint.constant = -(self.sideBarView.frame.width+10)
        sideBarView.layer.shadowOpacity = 0.5
        sideBarView.layer.shadowColor = UIColor.black.cgColor
        sideBarView.layer.shadowRadius = 3
        logInButton.layer.borderWidth = 1
        logInButton.layer.borderColor = UIColor.gray.cgColor
        logInButton.layer.cornerRadius = self.logInButton.frame.height/CGFloat(2)
        logInButton.tintColor = UIColor.lightGray
        logInButton.contentEdgeInsets = UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10)
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.sideBarLeadingConstraint.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func emptyAreaButtonAction(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.sideBarLeadingConstraint.constant = -(self.sideBarView.frame.width+10)
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0)
            self.view.layoutIfNeeded()
        }) { (bool) in
            UIApplication.shared.keyWindow?.windowLevel = (UIWindowLevelStatusBar - 1)
            self.dismiss(animated: false, completion: nil)
        }
    }
}
