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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideBarLeadingConstraint.constant = -sideBarView.frame.width
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
    
    
//    @IBAction func closeButton(_ sender: Any) {
//        UIView.animate(withDuration: 0.3, animations: {
//            self.sideBarLeadingConstraint.constant = -250
//            self.view.backgroundColor = UIColor.black.withAlphaComponent(0)
//            self.view.layoutIfNeeded()
//        }) { (bool) in
//            UIApplication.shared.keyWindow?.windowLevel = (UIWindowLevelStatusBar - 1)
//            self.dismiss(animated: false, completion: nil)
//            //            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "test"), object: nil)
//        }
//    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
