//
//  ListContainerViewController.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 4. 25..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit


class ListContainerViewController: UIViewController {
    var listTableViewController = UIViewController()
    var listMapViewController = UIViewController()
    var isMapView = false

    @IBOutlet weak var listMapView: UIView!
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var viewSwitchButtonItem: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "맞춤카페 목록"
        listMapView.isHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)

        listTableViewController = UIStoryboard.ListViewStoryboard.instantiateViewController(withIdentifier: "ListView")
        listMapViewController = UIStoryboard.ListMapViewStoryboard.instantiateViewController(withIdentifier: "ListMap")
        
        NetworkCafe.getCafeList(coordinate: Location.sharedInstance.currentLocation) { (modelCafe) in
            for cafe in modelCafe {
                let isCafe = Cafe.sharedInstance.cafeList.filter({ (cafeList) -> Bool in
                    return cafeList.getCafe()["id"] as! String == cafe.getCafe()["id"] as! String
                })
                if isCafe.isEmpty {
                    Cafe.sharedInstance.cafeList.append(cafe)
                }
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTableView"), object: nil)
        }
    }
    
    @IBAction func listViewSwitchToggleButtonAction(_ sender: Any) {
        viewSwitchButtonItem.image = isMapView ? #imageLiteral(resourceName: "map_Bt") : #imageLiteral(resourceName: "list_Bt")
        
        let newController = isMapView ? listTableViewController : listMapViewController
        let oldController = childViewControllers.last
        
        oldController?.willMove(toParentViewController: nil)
        addChildViewController(newController)
        newController.view.frame = (oldController?.view.frame)!
        transition(from: oldController!, to: newController, duration: 0.3, options: isMapView ? .transitionFlipFromLeft : .transitionFlipFromRight, animations: {
        }) { _ in
            oldController?.removeFromParentViewController()
            newController.didMove(toParentViewController: self)
        }
        isMapView = !isMapView
    }

    @IBAction func showFilterViewButtonItem(_ sender: Any) {
        let filterViewController = UIStoryboard.FilterViewStoryboard.instantiateViewController(withIdentifier: "FilterView")
        present(filterViewController, animated: true, completion: nil)
    }
}
