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
    var selectedFilterArray = [String]()

    @IBOutlet weak var listMapView: UIView!
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var viewSwitchButtonItem: UIBarButtonItem!
    
    func savedFilter(SavedFilter pickedFilter: [String?]) {
        selectedFilterArray = [String]()
        for filter in pickedFilter {
            selectedFilterArray.append(filter!)
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
        print("filterArray 1 : ", selectedFilterArray)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("filterArray 2 : ", selectedFilterArray)
        applyFilter()
        print(Cafe.sharedInstance.filterCafeList.count, "------------------")
        if selectedFilterArray.count != 0 {
            if let categoryXib = Bundle.main.loadNibNamed("ShowCategoryView", owner: self, options: nil)?.first as? ShowCategoryView {
                var isFilter = ""
                for filter in selectedFilterArray {
                    isFilter += "#\(filter) "
                }
                categoryXib.category.text = isFilter
                self.view.addSubview(categoryXib)
            }
        }
    }
    
    func applyFilter() {
        cafeFilter(filterArray: selectedFilterArray)
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
        showFilterView()
    }
    
    func showFilterView() {
        let filterViewController = UIStoryboard.FilterViewStoryboard.instantiateViewController(withIdentifier: "FilterView") as! FilterViewController
        let filterViewNavigationController = UINavigationController(rootViewController: filterViewController)
        filterViewController.delegate = self
        filterViewController.filterArray = self.selectedFilterArray
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
