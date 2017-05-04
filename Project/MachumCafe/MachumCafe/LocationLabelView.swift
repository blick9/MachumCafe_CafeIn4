//
//  LocationLabelView.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 5. 4..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class LocationLabelView: UIView {

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var setLocationButton: UIButton!
    
    func presentSetLocationView(target: UIButton) {
        let setLocationStoryboard = UIStoryboard(name: "SetLocationMapView", bundle: nil)
        let setLocationViewController = setLocationStoryboard.instantiateViewController(withIdentifier: "SetMyLocationMapView")
        let embedNavigationControllerSetLocationView = UINavigationController(rootViewController: setLocationViewController)
        
        target.inputViewController?.present(embedNavigationControllerSetLocationView, animated: true, completion: nil)
        
        print("test")
        
//        let logInStoryboard = UIStoryboard(name: "LogIn&SignUpView", bundle: nil)
//        let logInViewController = logInStoryboard.instantiateViewController(withIdentifier: "LogIn")
//        target.present(logInViewController, animated: true, completion: nil)
    }
    
}
