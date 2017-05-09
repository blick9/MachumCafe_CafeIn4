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

    @IBOutlet weak var googleMap: GMSMapView!
    @IBOutlet weak var cafeName: UILabel!
    @IBOutlet weak var cafeAddress: UILabel!
    @IBOutlet weak var cafeImageView: UIImageView!
    @IBOutlet weak var cafeInfoView: UIView!
    @IBOutlet weak var cafeInfoViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        loadModelCafeData()
        
        //locationManager - 좌표 알려주는 매니져
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
        googleMap.padding = mapPaddingInsets
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
        modelCafe = Cafe.sharedInstance.cafeList
    }
    
    func insertCafeMarkers() {
//        modelCafe.forEach { (cafeData) in
//            let cafe = cafeData.getCafe()
//            let latitude = cafe["latitude"] as! String
//            let longitude = cafe["longitude"] as! String
//            let cafeImage = cafe["imagesData"] as! [Data]
//            
//            createMarker(titleMarker: cafe["name"] as! String, snippetMarker: cafe["address"] as! String, image: #imageLiteral(resourceName: "1"), targetData: cafeData, latitude: Double(latitude)!, longitude: Double(longitude)!)
//        }
        
        var dynamicDouble : Double = 0.001
        for item in 0..<20 {
            var latitude = 37.50
            var longitude = 127.00
            
            createMarker(titleMarker: "\(latitude+dynamicDouble)", snippetMarker: "\(longitude)", image: nil, targetData: nil, latitude: latitude+dynamicDouble, longitude: longitude)
            createMarker(titleMarker: "\(latitude+dynamicDouble)", snippetMarker: "\(longitude+dynamicDouble)", image: nil, targetData: nil, latitude: latitude+dynamicDouble, longitude: longitude+dynamicDouble)
            createMarker(titleMarker: "\(latitude)", snippetMarker: "\(longitude+dynamicDouble)", image: nil, targetData: nil, latitude: latitude, longitude: longitude+dynamicDouble)
            createMarker(titleMarker: "\(latitude-dynamicDouble)", snippetMarker: "\(longitude+dynamicDouble)", image: nil, targetData: nil, latitude: latitude-dynamicDouble, longitude: longitude+dynamicDouble)
            
            createMarker(titleMarker: "\(latitude-dynamicDouble)", snippetMarker: "\(longitude)", image: nil, targetData: nil, latitude: latitude-dynamicDouble, longitude: longitude)
            createMarker(titleMarker: "\(latitude-dynamicDouble)", snippetMarker: "\(longitude-dynamicDouble)", image: nil, targetData: nil, latitude: latitude-dynamicDouble, longitude: longitude-dynamicDouble)
            createMarker(titleMarker: "\(latitude)", snippetMarker: "\(longitude-dynamicDouble)", image: nil, targetData: nil, latitude: latitude, longitude: longitude-dynamicDouble)
            createMarker(titleMarker: "\(latitude+dynamicDouble)", snippetMarker: "\(longitude-dynamicDouble)", image: nil, targetData: nil, latitude: latitude+dynamicDouble, longitude: longitude-dynamicDouble)

            print(latitude+dynamicDouble, longitude+dynamicDouble)
            dynamicDouble += 0.001
        }
    }
    
    func refreshCafeMarkers() {
        googleMap.clear()
        insertCafeMarkers()
    }
    
    
    // Part - Delegate : GMSMapViewDelegate
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        isTapMarker = false
        infoViewAnimate()
        print(coordinate)

        // MARK: GooglePlace를 통한 정보 가져오기. (다시 사용시 googlePlaces 모듈 import 할 것)
//        NetworkMap.searchCafeAroundMe(latitude: coordinate.latitude, longitude: coordinate.longitude) { (cafeInfoArray) in
//            NetworkMap.spreadMarker(cafeInfoArray: cafeInfoArray, callback: { (cafeInfo, name, address) in
//                self.createMarker(titleMarker: name, snippetMarker: address, iconMarker: #imageLiteral(resourceName: "marker") , latitude: cafeInfo["cafeLatitude"]! as!CLLocationDegrees, longitude: cafeInfo["cafeLongitude"]! as! CLLocationDegrees)
//            })
//        }
//        createMarker(titleMarker: "", snippetMarker: "", iconMarker: #imageLiteral(resourceName: "locationIcon"), latitude: coordinate.latitude, longitude: coordinate.longitude)
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
//        currentSelectedCafe = userData[1] as! ModelCafe
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
    
    // Part - Method : 맵에 마커 생성하는 함수
    func createMarker(titleMarker : String, snippetMarker : String, image: UIImage?, targetData: Any?, latitude : CLLocationDegrees, longitude : CLLocationDegrees) {
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        marker.title = titleMarker
        marker.snippet = snippetMarker
        marker.userData = [image, targetData]
//        marker.icon = GMSMarker.markerImage(with: .black)
        marker.icon = #imageLiteral(resourceName: "locationIcon")
        marker.map = googleMap
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailView" {
            let controller = segue.destination as! CafeDetailViewController
            controller.cafeModel = currentSelectedCafe
        }
    }
    
}
