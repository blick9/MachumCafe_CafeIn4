//
//  StaticFunction.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 5. 2..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

extension UIAlertController {
    func presentSuggestionLogInAlert(target : UIViewController, title : String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "닫기", style: .default)
        let logInAction = UIAlertAction(title: "로그인", style: .default) { _ in
            let logInStoryboard = UIStoryboard(name: "LogIn&SignUpView", bundle: nil)
            let logInViewController = logInStoryboard.instantiateViewController(withIdentifier: "LogIn")
            target.present(logInViewController, animated: true, completion: nil)
        }
        alertController.addAction(okAction)
        alertController.addAction(logInAction)
        target.present(alertController, animated: true, completion: nil)
    }
    
    func oneButtonAlert(target: UIViewController, title: String, message: String, isHandler: Bool) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            if isHandler {
                target.dismiss(animated: true, completion: nil)
            }
        }))
        target.present(alertController, animated: true, completion: nil)
    }
}

extension UIActivityIndicatorView {
    func showActivityIndicatory(view: UIView) -> UIView {
        let container: UIView = UIView()
        container.frame = view.frame
        container.center = view.center
        container.backgroundColor = UIColor.gray
        container.alpha = 0.8
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = view.center
        loadingView.backgroundColor = UIColor.black
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        let activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.whiteLarge
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        view.addSubview(container)
        activityIndicator.startAnimating()
        return container
    }
    
    func stopActivityIndicator(view: UIView, currentIndicator : UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            currentIndicator.alpha = 0
        }) { _ in
            currentIndicator.removeFromSuperview()
        }
    }
}

extension UIBarButtonItem {
    static var isSelected: Bool {
        return false
    }
}

extension UIStoryboard {
    static let MainViewStoryboard = UIStoryboard(name: "MainView", bundle: nil)
    static let ListContainerViewStoryboard = UIStoryboard(name: "ListContainerView", bundle: nil)
    static let ListViewStoryboard = UIStoryboard(name: "ListView", bundle: nil)
    static let ListMapViewStoryboard = UIStoryboard(name: "ListMapView", bundle: nil)
    static let FilterViewStoryboard = UIStoryboard(name: "FilterView", bundle: nil)
    static let LogInSignUpViewStoryboard = UIStoryboard(name: "LogIn&SignUpView", bundle: nil)
    static let BookmarkViewStoryboard = UIStoryboard(name: "BookmarkView", bundle: nil)
    static let SuggestionViewStoryboard = UIStoryboard(name: "SuggestionView", bundle: nil)
    static let SettingViewStoryboard = UIStoryboard(name: "SettingView", bundle: nil)
    static let SetLocationMapViewStoryboard = UIStoryboard(name: "SetLocationMapView", bundle: nil)
    static let ReviewViewStoryboard = UIStoryboard(name: "ReviewView", bundle: nil)
    static let CafeDetailViewStoryboard = UIStoryboard(name: "CafeDetailView", bundle: nil)
}

public func getCafeListFromCurrentLocation() {
    NetworkCafe.getCafeList(coordinate: Location.sharedInstance.currentLocation) { (modelCafe) in
        Cafe.sharedInstance.allCafeList = modelCafe
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTableView"), object: nil)
    }
}

public let categoryArray = ["24시", "연중무휴", "주차", "편한의자", "좌식", "모임", "미팅룸", "스터디", "넓은공간", "아이와함께", "디저트", "베이커리", "로스팅", "산책로", "모닥불", "드라이브", "북카페", "이색카페", "야경", "조용한", "고급스러운", "여유로운", "힐링", "테라스"]

extension Double {
    mutating func roundToPlaces(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return Darwin.round(self * divisor) / divisor
    }
    
    mutating func meterConvertToKiloMeter(places: Int) -> Double {
        var result = Double()
        if self > 1000 {
            var kiloMeter = self / 1000
            result = kiloMeter.roundToPlaces(places: places)
        } else {
            result = self.roundToPlaces(places: 0)
        }
        return result
    }
}

extension String {
    func returnDistanceByMeasure(distance: Double) -> String {
        var dist = distance
        let convertByDistance = dist.meterConvertToKiloMeter(places: 2)
        let result = distance > 1000 ? "\(convertByDistance)km" : "\(Int(convertByDistance))m"
        return result
    }
    
    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: self)
    }
    
    var isPassword: Bool {
        return self.characters.count >= 6 ? true : false
    }
}

