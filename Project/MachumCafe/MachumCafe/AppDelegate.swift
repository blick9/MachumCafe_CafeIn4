//
//  AppDelegate.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 4. 25..
//  Copyright © 2017년 Febrix. All rights reserved.
//
// TODO: 카카오톡 로그인 연동 리팩토링! ! !

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
        
        // MARK: 카톡 로그인 세션 있을 경우 유저정보 Get, 없을경우 우리 서버에서 유저정보 Get, 둘다 세션 없을경우 nil
        let session = KOSession.shared()
        // 카톡 세션 있을 시 유저 정보 모델 저장
        if (session?.isOpen())! {
            KOSessionTask.meTask(completionHandler: { (profile, error) in
                if let userProfile = profile {
                    let user = userProfile as! KOUser
                    let email = user.email!
                    
                    NetworkUser.kakaoLogin(email: email, nickname: String(), imageURL: String()) { (result, user) in
                        User.sharedInstance.user = user
                        User.sharedInstance.isUser = true
                        if !(user.getUser()["profileImageURL"] as! String).isEmpty {
                            NetworkUser.getUserImage(userID: user.getUser()["id"] as? String, isKakaoImage: user.getUser()["isKakaoImage"] as! Bool, imageURL: user.getUser()["profileImageURL"] as! String) { (imageData) in
                                user.setProfileImage(profileImage: imageData)
                            }
                        }
                    }
                }
            })
        } else {
            // 카톡 유저 아닐 경우 우리 서버에서 세션 확인 후 모델 저장
            NetworkUser.getUser { (result, user) in
                if result {
                    User.sharedInstance.user = user
                    User.sharedInstance.isUser = true
                    if !(user.getUser()["profileImageURL"] as! String).isEmpty {
                        NetworkUser.getUserImage(userID: user.getUser()["id"] as? String, isKakaoImage: user.getUser()["isKakaoImage"] as! Bool, imageURL: user.getUser()["profileImageURL"] as! String) { (imageData) in
                            user.setProfileImage(profileImage: imageData)
                        }
                    }
                }
            }
        }
        KOSession.shared().isAutomaticPeriodicRefresh = true

        initLocationManager()
        return true
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        if KOSession.isKakaoAccountLoginCallback(url) {
            return KOSession.handleOpen(url)
        }
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if KOSession.isKakaoAccountLoginCallback(url) {
            return KOSession.handleOpen(url)
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        KOSession.handleDidEnterBackground()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        initLocationManager()
        KOSession.handleDidBecomeActive()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
//        print("url:\(url)")
//        print("urlhost: \(url.host)")
//        print("urlPath: \(url.path)")
//        
//        let urlPath : String = url.path as String!
//        let urlHost : String = url.host as String!
//        
//        if(urlPath == "/inner") {
//            NetworkCafe.getSpecificCafe(cafeId: "59183c36b5b73265b1dc3360") { (modelCafe) in
//                Cafe.sharedInstance.specificCafe = modelCafe
//                let mainViewController = UIStoryboard.MainViewStoryboard.instantiateViewController(withIdentifier: "Main")
//                let cafeDetailViewController = UIStoryboard.CafeDetailViewStoryboard.instantiateViewController(withIdentifier: "CafeDetailView") as! CafeDetailViewController
//                let cafeDetailNavigationViewController = UINavigationController(rootViewController: cafeDetailViewController)
//                cafeDetailViewController.currentCafeModel = Cafe.sharedInstance.specificCafe
//                self.window?.rootViewController = mainViewController
//                mainViewController.navigationController?.pushViewController(cafeDetailNavigationViewController, animated: true)
//            }
//            
//        }
//        self.window?.makeKeyAndVisible()
//        return true
//    }
    
    
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
