//
//  ListContainerViewController.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 4. 25..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class ListContainerViewController: UIViewController, SavedFilterDelegate {
    var listTableViewController = UIViewController()
    var listMapViewController = UIViewController()
    var isMapView = false
    var filterArray = [String]()

    @IBOutlet weak var listMapView: UIView!
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var viewSwitchButtonItem: UIBarButtonItem!
    
    func savedFilter(SavedFilter pickedFilter: [String?]) {
        filterArray = [String]()
        for filter in pickedFilter {
            filterArray.append(filter!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "맞춤카페 목록"
        listMapView.isHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)

        listTableViewController = UIStoryboard.ListViewStoryboard.instantiateViewController(withIdentifier: "ListView")
        listMapViewController = UIStoryboard.ListMapViewStoryboard.instantiateViewController(withIdentifier: "ListMap")
        
        NotificationCenter.default.addObserver(self, selector: #selector(applyFilter), name: NSNotification.Name(rawValue: "applyFilter"), object: nil)
        print("filterArray 1 : ", filterArray)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("filterArray 2 : ", filterArray)
        applyFilter()
        print(Cafe.sharedInstance.filterCafeList.count, "------------------")
    }
    
    func applyFilter() {
        cafeFilter(filterArray: filterArray)
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
        let filterViewController = UIStoryboard.FilterViewStoryboard.instantiateViewController(withIdentifier: "FilterView") as! FilterViewController
        let filterViewNavigationController = UINavigationController(rootViewController: filterViewController)
        filterViewController.delegate = self
        filterViewController.filterArray = self.filterArray
        present(filterViewNavigationController, animated: true, completion: nil)
    }
    
    func cafeFilter(filterArray: [String]) {
        Cafe.sharedInstance.filterCafeList = [ModelCafe]()
        
        let allCafeList = Cafe.sharedInstance.allCafeList
        let _ = allCafeList.map { (cafe) in
            var result = [String]()
            for category in cafe.getCafe()["category"] as! [String] {
                for filter in filterArray {
                    if category == filter {
                        result.append(filter)
                    }
                }
            }
            if result.sorted() == filterArray.sorted() {
                Cafe.sharedInstance.filterCafeList.append(cafe)
            }
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTableView"), object: nil)
    }
}
