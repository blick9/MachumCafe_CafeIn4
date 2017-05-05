//
//  SetLocationMapViewController.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 5. 4..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit
import GoogleMaps

class SetLocationMapViewController: UIViewController {
    var locationManager = CLLocationManager()
    var currentLocation = CLLocationCoordinate2D()

    @IBOutlet weak var googleMap: GMSMapView!
    @IBOutlet weak var currentAddress: UILabel!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var addressView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "내 위치 설정"
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingHeading()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
        
        googleMap.camera = GMSCameraPosition.camera(withLatitude: 37.506139582014775, longitude: 127.03659117221832, zoom: 13.0)
        googleMap.delegate = self
        googleMap.isMyLocationEnabled = true
        googleMap.settings.myLocationButton = true
        googleMap.settings.zoomGestures = true
        googleMap.settings.rotateGestures = false
        googleMap.settings.tiltGestures = false
        
        let markerImage = UIImageView(frame: CGRect(x: googleMap.center.x-14, y: googleMap.center.y-30-40, width: 0, height: 0))
        markerImage.image = #imageLiteral(resourceName: "MapMarker")
        markerImage.sizeToFit()
        view.addSubview(markerImage)
        applyButton.tintColor = UIColor(red: 255, green: 232, blue: 129)
        addressView.layer.cornerRadius = 3
    }

    
    @IBAction func applyButtonAction(_ sender: Any) {
        // 저장시 모델에 좌표값, 주소 저장.
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setLocation"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension SetLocationMapViewController : GMSMapViewDelegate, CLLocationManagerDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        currentLocation = CLLocationCoordinate2D(latitude: position.target.latitude, longitude: position.target.longitude)
        
        NetworkMap.getAddressFromCoordinate(latitude: position.target.latitude, longitude: position.target.longitude) { (address) in
            self.currentAddress.text = address[0]
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        googleMap.animate(toLocation: coordinate)
    }
}
