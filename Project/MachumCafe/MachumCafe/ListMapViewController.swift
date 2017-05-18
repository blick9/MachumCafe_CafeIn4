//
//  ListMapViewController.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 4. 26..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit
import GoogleMaps

class ListMapViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var modelCafe = [ModelCafe]()
    var currentSelectedCafe = ModelCafe()
    var isTapMarker = false
    var mapPaddingInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    var currentLocation = [String : Any]()

    @IBOutlet weak var googleMap: GMSMapView!
    @IBOutlet weak var cafeName: UILabel!
    @IBOutlet weak var cafeAddress: UILabel!
    @IBOutlet weak var cafeImageView: UIImageView!
    @IBOutlet weak var cafeInfoView: UIView!
    @IBOutlet weak var cafeInfoViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingHeading()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
        
        googleMap.camera = GMSCameraPosition.camera(withLatitude: 36.609145122457349, longitude: 127.81414780765772, zoom: 7.0)
        googleMap.delegate = self
        googleMap.isMyLocationEnabled = true
        googleMap.settings.myLocationButton = true
        googleMap.settings.zoomGestures = true
        googleMap.padding = mapPaddingInsets
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshCafeMarkers()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if currentLocation["latitude"] as! Double != 0 {
            googleMap.animate(toLocation: CLLocationCoordinate2D(latitude: currentLocation["latitude"] as! Double, longitude: currentLocation["longitude"] as! Double))
            googleMap.animate(toZoom: 14)
        }
    }
    
    func refreshCafeMarkers() {
        googleMap.clear()
        loadModelCafeData()
        insertCafeMarkers()
    }
    
    func initView() {
        cafeInfoViewBottomConstraint.constant = -(cafeInfoView.frame.height+10)
        cafeInfoView.layer.cornerRadius = 5
        cafeInfoView.layer.borderColor = UIColor.lightGray.cgColor
        cafeInfoView.layer.borderWidth = 0.5
        cafeImageView.backgroundColor = UIColor.white
        cafeImageView.layer.borderColor = UIColor.lightGray.cgColor
        cafeImageView.layer.borderWidth = 0.5
        cafeImageView.layer.masksToBounds = true
    }
    
    func loadModelCafeData() {
        currentLocation = Location.sharedInstance.currentLocation.getLocation()
        let distance = Location.sharedInstance.getCoordinateDistance(meter: 1000)
        
        modelCafe = Cafe.sharedInstance.allCafeList.filter {
            (currentLocation["latitude"] as! Double) - distance <= $0.getLatitude() && $0.getLatitude() <= (currentLocation["latitude"] as! Double) + distance && (currentLocation["longitude"] as! Double) - distance <= $0.getLongitude() && $0.getLongitude() <= (currentLocation["longitude"] as! Double) + distance
        }
    }
    
    func insertCafeMarkers() {
        modelCafe.forEach { (cafeData) in
            let cafe = cafeData.getCafe()
            let latitude = cafe["latitude"] as! Double
            let longitude = cafe["longitude"] as! Double
//            let cafeImage = cafe["imagesData"] as! [Data]
            createMarker(titleMarker: cafe["name"] as! String, snippetMarker: cafe["address"] as! String, image: #imageLiteral(resourceName: "1"), targetData: cafeData, latitude: latitude, longitude: longitude)
        }
    }
    
    func tempMakeCircle() {
        let circleCenter = CLLocationCoordinate2D(latitude: currentLocation["latitude"] as! Double, longitude: currentLocation["longitude"] as! Double)
        let circ = GMSCircle(position: circleCenter, radius: 1000)
        
        circ.fillColor = UIColor(red: 0.35, green: 0, blue: 0, alpha: 0.03)
        circ.strokeColor = .red
        circ.strokeWidth = 1
        circ.map = googleMap
    }
    
    
    
    // Part - Delegate : GMSMapViewDelegate
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        isTapMarker = false
        infoViewAnimate()
        print(coordinate)
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        isTapMarker = true
        infoViewAnimate()
        
        let userData = marker.userData as! [Any]
        //MARK: Zoom이 12Lv 이하일 경우 Camera Move와 동시에 14Lv로 확대
        googleMap.animate(toLocation: marker.position)
        if googleMap.camera.zoom <= 12 { googleMap.animate(toZoom: 14) }
        cafeName.text = marker.title
        cafeAddress.text = marker.snippet
        cafeImageView.image = userData[0] as? UIImage
        currentSelectedCafe = userData[1] as! ModelCafe
        return true
    }
    
    func infoViewAnimate() {
        if isTapMarker {
            mapPaddingInsets = UIEdgeInsets(top: 0, left: 0, bottom: 130, right: 0)
            UIView.animate(withDuration: 0.3, animations: {
                self.googleMap.padding = self.mapPaddingInsets
                self.cafeInfoViewBottomConstraint.constant = 10
                self.view.layoutIfNeeded()
            })
        } else {
            mapPaddingInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            UIView.animate(withDuration: 0.3, animations: {
                self.googleMap.padding = self.mapPaddingInsets
                self.cafeInfoViewBottomConstraint.constant = -(self.cafeInfoView.frame.height+10)
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func createMarker(titleMarker : String, snippetMarker : String, image: UIImage?, targetData: Any?, latitude : CLLocationDegrees, longitude : CLLocationDegrees) {
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        marker.title = titleMarker
        marker.snippet = snippetMarker
        marker.userData = [image, targetData]
        marker.icon = GMSMarker.markerImage(with: .black)
//        marker.icon = #imageLiteral(resourceName: "locationIcon")
        marker.map = googleMap
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailView" {
            let controller = segue.destination as! CafeDetailViewController
            controller.cafeModel = currentSelectedCafe
        }
    }
    
}
