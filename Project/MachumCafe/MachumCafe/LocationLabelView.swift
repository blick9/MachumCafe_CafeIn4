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
        let setLocationViewNavigationController = UINavigationController(rootViewController: setLocationViewController)
//        self.present(setLocationViewNavigationController, animated: true, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshAddress), name: NSNotification.Name(rawValue: "setLocation"), object: nil)
    }
    
    func refreshAddress() {
        layoutSubviews()
    }

    override func layoutSubviews() {
        print("layoutSubView")
    }
}
