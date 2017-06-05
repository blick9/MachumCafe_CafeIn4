//
//  LocationLabelView.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 5. 4..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class LocationLabelView: UIView {
    
    weak var delegate: UIViewController?
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var setLocationButton: UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshAddress), name: NSNotification.Name(rawValue: "setLocation"), object: nil)
    }
    
    func refreshAddress() {
        layoutSubviews()
    }
    
    @IBAction func presentSetLocationMapViewButtonAction(_ sender: Any) {
        let setLocationViewController = UIStoryboard.SetLocationMapViewStoryboard.instantiateViewController(withIdentifier: "SetMyLocationMapView")
        let setLocationViewNavigationController = UINavigationController(rootViewController: setLocationViewController)
        self.delegate?.present(setLocationViewNavigationController, animated: true, completion: nil)
    }

    override func layoutSubviews() {
        if let address = Location.sharedInstance.currentLocation.getLocation()["address"] as? String {
            addressLabel.text = address
        } else {
            addressLabel.text = "위치 정보가 없습니다."
        }
    }
}
