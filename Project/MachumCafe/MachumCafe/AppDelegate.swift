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
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var googleAPIKey = "AIzaSyBJK14xRWA8NkVirhJxmpuO9FvKvARRmfY"
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        GMSServices.provideAPIKey(googleAPIKey)
        GMSPlacesClient.provideAPIKey(googleAPIKey)
        
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor(red: 51, green: 51, blue: 51)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor(red: 255, green: 232, blue: 129)]
        
        UINavigationBar.appearance().isTranslucent = false
        
//        NetworkUser.register(email: "asdf", password: "asdf", nickname: "asdfasdf") { (bool) in
//            print(bool)
//        }

//        NetworkUser.logIn(email: "asdf", password: "asdf") { (bool, user) in
//            User.sharedInstance.user = user
//        }
        
        NetworkUser.getUser { (message, user) in
            User.sharedInstance.user = user
            print(user)
        }
        
        NetworkCafe.getAllCafeList { (cafe) in
            Cafe.sharedInstance.cafeList.append(contentsOf: cafe)
            print(User.sharedInstance.user.getUser()["id"] as! String)
            print(Cafe.sharedInstance.cafeList[0].getCafe()["id"] as! String)
        }
        
//        NetworkBookmark.setMyBookmark(userId: User.sharedInstance.user.getUser()["id"] as! String, cafeId: Cafe.sharedInstance.cafeList[0].getCafe()["id"] as! String) { (bool, string) in
//            print(bool)
//        }
//        
//        NetworkBookmark.getMyBookmark(userId: User.sharedInstance.user.getUser()["id"] as! String) { (message, cafe) in
//            print(cafe)
//        }
        
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
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

