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
import Alamofire
import SwiftyJSON

class ListMapViewController: UIViewController,GMSMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var googleMap: GMSMapView!
    
    var locationManager = CLLocationManager()
    var placesClient: GMSPlacesClient!
    var currentLocation = [String: Double]()
    let urlMapKey = "AIzaSyDT_p0qtF5htzJ8Ly4h8fxfG-gB30aMp9M"
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
        currentLocation["longtitude"] = coordinate.longitude
        
        
        searchCafeAroundMe(latitude: coordinate.latitude, longtitude: coordinate.longitude) { (cafeInfoArray) in
            self.spreadMarker(cafeInfoArray: cafeInfoArray)
        }
        
        createMarker(titleMarker: "", snippetMarker: "", iconMarker: #imageLiteral(resourceName: "locationIcon"), latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
    
//    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
//        // cafeName.text = marker.title
//        // cafeAddress.text = marker.snippet
//        return true
//    }
    
    // Part - Method : 맵에 마커 생성하는 기능
    func createMarker(titleMarker : String, snippetMarker : String, iconMarker: UIImage, latitude : CLLocationDegrees, longitude : CLLocationDegrees) {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(latitude, longitude)
        marker.title = titleMarker
        marker.snippet = snippetMarker
        marker.icon = iconMarker
        marker.map = googleMap
    }
    
    // Part - Method : 내 주위 700미터 안의 카페 탐색
    func searchCafeAroundMe (latitude : CLLocationDegrees, longtitude: CLLocationDegrees, completion : @escaping ([[String : Any]]) -> Void) {
        
        var cafeInfo = [String : Any]()
        var cafeInfoArray = [[String : Any]]()
        
        let aroundMeURL = "https://maps.googleapis.com/maps/api/place/radarsearch/json?location=\(latitude),\(longtitude)&radius=700&type=cafe&key=AIzaSyDT_p0qtF5htzJ8Ly4h8fxfG-gB30aMp9M"
        
        Alamofire.request(aroundMeURL).responseJSON { responds in
            let json = JSON(data: responds.data!)
            let results = json["results"].arrayValue
            
            for result in results {
                let geometry = result["geometry"].dictionaryValue
                let location = geometry["location"]?.dictionary
                let cafeLatitude = location?["lat"]?.doubleValue
                let cafeLongtitude = location?["lng"]?.doubleValue
                let cafeInfoID = result["place_id"].stringValue
                
                cafeInfo["cafeLatitude"] = cafeLatitude
                cafeInfo["cafeLongtitude"] = cafeLongtitude
                cafeInfo["cafeInfoID"] = cafeInfoID
                cafeInfoArray.append(cafeInfo)
            }
            completion(cafeInfoArray)
        }
    }
    // Part - Method : 마커 뿌리기
    func spreadMarker (cafeInfoArray : [[String : Any]]) {
        for cafeInfo in cafeInfoArray {
            let cafeURL = "https://maps.googleapis.com/maps/api/place/details/json?placeid=\(String(describing: cafeInfo["cafeInfoID"]!))&language=ko&key=AIzaSyDT_p0qtF5htzJ8Ly4h8fxfG-gB30aMp9M"
            
            Alamofire.request(cafeURL).responseJSON { responds in
                let json = JSON(data: responds.data!)
                let result = json["result"].dictionary
                let address = result?["formatted_address"]?.stringValue
                let name = result?["name"]?.stringValue
                
                self.createMarker(titleMarker: name!, snippetMarker: address!, iconMarker: #imageLiteral(resourceName: "marker") , latitude: cafeInfo["cafeLatitude"]! as!CLLocationDegrees, longitude: cafeInfo["cafeLongtitude"]! as! CLLocationDegrees)
            }
        }
    }

    
}
