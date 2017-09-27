//
//  SetLocationMapViewController.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 5. 4..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class SetLocationMapViewController: UIViewController, UISearchControllerDelegate {
    
    var locationManager = CLLocationManager()
    var currentLocation = ModelLocation()
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?

    @IBOutlet weak var googleMap: GMSMapView!
    @IBOutlet weak var currentAddress: UILabel!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var addressView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "내 위치 설정"
        
        GMSAutocompleteInit()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingHeading()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges() 
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 10.0
        
        let mapInsets = UIEdgeInsets(top: 0, left: 0, bottom: 90, right: 0)
        googleMap.camera = GMSCameraPosition.camera(withLatitude: 37.506139582014775, longitude: 127.03659117221832, zoom: 13.0)
        googleMap.delegate = self
        googleMap.isMyLocationEnabled = true
        googleMap.settings.myLocationButton = true
        googleMap.settings.zoomGestures = true
        googleMap.settings.rotateGestures = false
        googleMap.settings.tiltGestures = false
        googleMap.padding = mapInsets
        
        // x : -14 = markerImage Width / 2
        // y : -40 = markerImage Height
        let markerImage = UIImageView(frame: CGRect(x: googleMap.center.x-14, y: googleMap.center.y-(mapInsets.bottom-10)-40, width: 0, height: 0))
        markerImage.image = #imageLiteral(resourceName: "mapPin")
        markerImage.sizeToFit()
        view.addSubview(markerImage)
        
        /* Center 조정용
        let adjustCenterPointView = UIView(frame: CGRect(x: googleMap.center.x, y: googleMap.center.y-(mapInsets.bottom-10), width: 3, height: 3))
        adjustCenterPointView.backgroundColor = UIColor.red
        view.addSubview(adjustCenterPointView)
         */
        
        applyButton.tintColor = UIColor(red: 255, green: 232, blue: 129)
        addressView.layer.cornerRadius = 3
        
        resultsViewController?.delegate = self
        let addressFilter = GMSAutocompleteFilter()
        addressFilter.type = .noFilter
        addressFilter.country = "KR"
        resultsViewController?.autocompleteFilter = addressFilter
    }
    
    func GMSAutocompleteInit() {
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.delegate = self
        searchController?.searchResultsUpdater = resultsViewController
    
        searchController?.searchBar.sizeToFit()
        navigationItem.titleView = searchController?.searchBar
        
        definesPresentationContext = true
        
        searchController?.hidesNavigationBarDuringPresentation = false
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        // Glitter Cancel Button
//        searchController.searchBar.showsCancelButton = false
//        resultsViewController?.autocompleteFilter?.type = .noFilter
//        resultsViewController?.autocompleteFilter?.country = "KR"
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
    @IBAction func applyButtonAction(_ sender: Any) {
        Location.sharedInstance.currentLocation = currentLocation
        getCafeListFromCurrentLocation()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension SetLocationMapViewController : GMSMapViewDelegate, CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        NetworkMap.getAddressFromCoordinate(latitude: position.target.latitude, longitude: position.target.longitude) { (address) in
            self.currentLocation.setLocation(latitude: position.target.latitude, longitude: position.target.longitude, address: address[0])
            self.currentAddress.text = address[0]
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        googleMap.animate(toLocation:  coordinate)
        print(coordinate)
        /* Center 조정용 Marker
        let adjustCenterPointMarker = GMSMarker(position: coordinate)
        adjustCenterPointMarker.icon = GMSMarker.markerImage(with: .black)
        adjustCenterPointMarker.map = googleMap
         */
    }
}

extension SetLocationMapViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        googleMap.animate(toLocation: place.coordinate)
        googleMap.animate(toZoom: 15)
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        print("Error: ", error.localizedDescription)
    }
    
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
