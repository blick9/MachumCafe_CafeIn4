//
//  ListMapViewController.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 4. 26..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit
import GoogleMaps

class ListMapViewController: UIViewController{
    
    var locationManager = CLLocationManager()
    var modelCafe = [ModelCafe]()
    var currentSelectedCafe = ModelCafe()
    var isTapMarker = false
    var mapPaddingInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    var currentLocation = [String : Any]()
    var markerIDArray = [String]()

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

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingHeading()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
        
        googleMap.camera = GMSCameraPosition.camera(withLatitude: currentLocation["latitude"] as! Double, longitude: currentLocation["longitude"] as! Double, zoom: 14)
        googleMap.delegate = self
        googleMap.isMyLocationEnabled = true
        googleMap.settings.myLocationButton = true
        googleMap.settings.zoomGestures = true
        googleMap.padding = mapPaddingInsets
        NotificationCenter.default.addObserver(self, selector: #selector(refreshMapMarkers), name: NSNotification.Name(rawValue: "refreshMapMarkers"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshMapMarkers()
    }
    
    func refreshMapMarkers() {
        googleMap.clear()
        markerIDArray = [String]()
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
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "applyFilter"), object: nil)
        currentLocation = Location.sharedInstance.currentLocation.getLocation()
        modelCafe = Cafe.sharedInstance.filterCafeList
    }
    
    func insertCafeMarkers() {
        modelCafe.forEach { (cafeData) in
            let cafe = cafeData.getCafe()
            let cafeID = cafe["id"] as! String
            let cafeName = cafe["name"] as! String
            let cafeAddress = cafe["address"] as! String
            let latitude = cafe["latitude"] as! Double
            let longitude = cafe["longitude"] as! Double
            if !markerIDArray.contains(cafeID) {
                createMarker(titleMarker: cafeName, snippetMarker: cafeAddress, targetData: cafeData, latitude: latitude, longitude: longitude)
                markerIDArray.append(cafeID)
            }
        }
    }
    
    func createMarker(titleMarker : String, snippetMarker : String, targetData: Any?, latitude : CLLocationDegrees, longitude : CLLocationDegrees) {
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        marker.title = titleMarker
        marker.snippet = snippetMarker
        marker.userData = targetData
        marker.icon = GMSMarker.markerImage(with: .black)
        marker.appearAnimation = GMSMarkerAnimation.pop
        marker.map = googleMap
    }
    
    func tempMakeCircle() {
        let circleCenter = CLLocationCoordinate2D(latitude: currentLocation["latitude"] as! Double, longitude: currentLocation["longitude"] as! Double)
        let circ = GMSCircle(position: circleCenter, radius: 1000)
        
        circ.fillColor = UIColor(red: 0.35, green: 0, blue: 0, alpha: 0.03)
        circ.strokeColor = .red
        circ.strokeWidth = 1
        circ.map = googleMap
    }
    
    func getCafeListWhenMovedLocation(coordinate: CLLocationCoordinate2D) {
        NetworkCafe.getCafeList(coordinate: ModelLocation(latitude: coordinate.latitude, longitude: coordinate.longitude, address: "")) { (modelCafe) in
            var newCafeList = [ModelCafe]()
            for cafe in modelCafe {
                let isCafe = Cafe.sharedInstance.allCafeList.filter({ (cafeList) -> Bool in
                    return cafeList.getCafe()["id"] as! String == cafe.getCafe()["id"] as! String
                })
                if isCafe.isEmpty {
                    newCafeList.append(cafe)
                }
            }
            Cafe.sharedInstance.allCafeList = newCafeList + Cafe.sharedInstance.allCafeList
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTableView"), object: nil)
            self.loadModelCafeData()
            self.insertCafeMarkers()
        }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailView" {
            let controller = segue.destination as! CafeDetailViewController
            controller.currentCafeModel = currentSelectedCafe
        }
    }
}

extension ListMapViewController : GMSMapViewDelegate, CLLocationManagerDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        getCafeListWhenMovedLocation(coordinate: position.target)
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        isTapMarker = false
        infoViewAnimate()
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        isTapMarker = true
        infoViewAnimate()
        
        let cafe = marker.userData as! ModelCafe
        //MARK: Zoom이 12Lv 이하일 경우 Camera Move와 동시에 14Lv로 확대
        if (cafe.getCafe()["imagesData"] as! [Data]).isEmpty {
            NetworkCafe.getImagesData(imagesURL: cafe.getCafe()["imagesURL"] as! [String]) { (imageData) in
                (marker.userData as! ModelCafe).setImagesData(imageData: imageData)
                self.cafeImageView.image = UIImage(data: (cafe.getCafe()["imagesData"] as! [Data])[0])
            }
        } else {
            self.cafeImageView.image = UIImage(data: (cafe.getCafe()["imagesData"] as! [Data])[0])
        }
        
        googleMap.animate(toLocation: marker.position)
        if googleMap.camera.zoom <= 12 { googleMap.animate(toZoom: 14) }
        cafeName.text = marker.title
        cafeAddress.text = marker.snippet
        currentSelectedCafe = cafe
        return true
    }
}
