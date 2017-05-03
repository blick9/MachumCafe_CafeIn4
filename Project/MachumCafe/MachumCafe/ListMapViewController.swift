//
//  ListMapViewController.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 4. 26..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class ListMapViewController: UIViewController,GMSMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var googleMap: GMSMapView!
    @IBOutlet weak var cafeName: UILabel!
    @IBOutlet weak var cafeAddress: UILabel!
    
    var locationManager = CLLocationManager()
    var placesClient: GMSPlacesClient!
    var currentLocation = [String: Double]()
    override func viewDidLoad() {
        super.viewDidLoad()

        //locationManager - 좌표 알려주는 매니져
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingHeading()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
        
        let camera = GMSCameraPosition.camera(withLatitude: 37.404796, longitude: 127.106053, zoom: 15.0)
        self.googleMap.camera = camera
        self.googleMap.delegate = self
        self.googleMap?.isMyLocationEnabled = true
        self.googleMap.settings.myLocationButton = true
        self.googleMap.settings.zoomGestures = true
    }
    
    // Part - Delegate : GMSMapViewDelegate
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        googleMap.isMyLocationEnabled = true
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        googleMap.clear()
        currentLocation["latitude"] = coordinate.latitude
        currentLocation["longitude"] = coordinate.longitude
        
        NetworkMap.searchCafeAroundMe(latitude: coordinate.latitude, longitude: coordinate.longitude) { (cafeInfoArray) in
            NetworkMap.spreadMarker(cafeInfoArray: cafeInfoArray, callback: { (cafeInfo, name, address) in
                self.createMarker(titleMarker: name, snippetMarker: address, iconMarker: #imageLiteral(resourceName: "marker") , latitude: cafeInfo["cafeLatitude"]! as!CLLocationDegrees, longitude: cafeInfo["cafeLongitude"]! as! CLLocationDegrees)
            })
        }
        
        createMarker(titleMarker: "", snippetMarker: "", iconMarker: #imageLiteral(resourceName: "locationIcon"), latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
         cafeName.text = marker.title
         cafeAddress.text = marker.snippet
        return true
    }
    
    // Part - Method : 맵에 마커 생성하는 기능
    func createMarker(titleMarker : String, snippetMarker : String, iconMarker: UIImage, latitude : CLLocationDegrees, longitude : CLLocationDegrees) {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(latitude, longitude)
        marker.title = titleMarker
        marker.snippet = snippetMarker
        marker.icon = iconMarker
        marker.map = googleMap
    }
    
}
