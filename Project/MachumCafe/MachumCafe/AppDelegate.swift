//
//  AppDelegate.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 4. 25..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var googleAPIKey = "AIzaSyBJK14xRWA8NkVirhJxmpuO9FvKvARRmfY"
    var locationManager = CLLocationManager()
    var seenError : Bool = false
    var locationFixAchieved : Bool = false
    var locationStatus : NSString = "Not Started"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        GMSServices.provideAPIKey(googleAPIKey)
        GMSPlacesClient.provideAPIKey(googleAPIKey)
        let backButtonImage = #imageLiteral(resourceName: "back_Bt").stretchableImage(withLeftCapWidth: 13, topCapHeight: 22)
        UIBarButtonItem.appearance().setBackButtonBackgroundImage(backButtonImage, for: .normal, barMetrics: .default)

        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor(red: 51, green: 51, blue: 51)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor(red: 255, green: 232, blue: 129)]
        
        UINavigationBar.appearance().isTranslucent = false
        
        NetworkUser.getUser { (result, user) in
            if result {
                User.sharedInstance.user = user
                User.sharedInstance.isUser = true
            }
        }
        initLocationManager()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        initLocationManager()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func initLocationManager() {
        seenError = false
        locationFixAchieved = false
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.distanceFilter = 10.0
    }
    
    // Checking error in locationManager
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        if (seenError == false) {
            seenError = true
            print(error)
        }
    }
    // When location Updated
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var currentLocation = CLLocationCoordinate2D()
        if (locationFixAchieved == false) {
            locationFixAchieved = true
            currentLocation = CLLocationCoordinate2D(latitude: (locations.last?.coordinate.latitude)!, longitude: (locations.last?.coordinate.longitude)!)

            NetworkMap.getAddressFromCoordinate(latitude: (locations.last?.coordinate.latitude)!, longitude: (locations.last?.coordinate.longitude)!) { (address) in
                Location.sharedInstance.currentLocation = ModelLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude, address: address[0])
                getCafeListFromCurrentLocation()
            }
        }
    }
    // locationAuthorization
    private func locationManager(manager: CLLocationManager!,
                         didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        var shouldIAllow = false
        
        switch status {
        case CLAuthorizationStatus.restricted:
            locationStatus = "Restricted Access to location"
        case CLAuthorizationStatus.denied:
            locationStatus = "User denied access to location"
        case CLAuthorizationStatus.notDetermined:
            locationStatus = "Status not determined"
        default:
            locationStatus = "Allowed to location Access"
            shouldIAllow = true
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LabelHasbeenUpdated"), object: nil)
        if (shouldIAllow == true) {
            NSLog("Location to Allowed")
            // Start location services
            locationManager.startUpdatingLocation()
        } else {
            NSLog("Denied access: \(locationStatus)")
        }
    }
}
