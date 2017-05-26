//
//  ListContainerViewController.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 4. 25..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class ListContainerViewController: UIViewController, SavedFilterDelegate {
    var listTableViewController = UIViewController() as? ListViewController
    var listMapViewController = UIViewController()
    var isMapView = false
    var selectedFilterArray = [String]()
    
    @IBOutlet weak var listMapView: UIView!
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var viewSwitchButtonItem: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
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

        listTableViewController = UIStoryboard.ListViewStoryboard.instantiateViewController(withIdentifier: "ListView") as! ListViewController
        listMapViewController = UIStoryboard.ListMapViewStoryboard.instantiateViewController(withIdentifier: "ListMap")
        
        NotificationCenter.default.addObserver(self, selector: #selector(applyFilter), name: NSNotification.Name(rawValue: "applyFilter"), object: nil)
        print("filterArray 1 : ", selectedFilterArray)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "FilterCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        applyFilter()
        print(Cafe.sharedInstance.filterCafeList.count, "------------------")
        print("filterArray 2 : ", selectedFilterArray)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func applyFilter() {
        cafeFilter(filterArray: selectedFilterArray)
        collectionView.reloadData()
    }
    
    @IBAction func listViewSwitchToggleButtonAction(_ sender: Any) {
        viewSwitchButtonItem.image = isMapView ? #imageLiteral(resourceName: "map_Bt") : #imageLiteral(resourceName: "list_Bt")
        
        let newController = isMapView ? listTableViewController! : listMapViewController
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

extension ListContainerViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedFilterArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FilterCollectionViewCell
        cell.backgroundColor = UIColor(red: 255, green: 232, blue: 129)
        cell.category.text = selectedFilterArray[indexPath.row]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Double((selectedFilterArray[indexPath.row] as String).unicodeScalars.count) * 15.0 + 10
        return CGSize(width: width, height: 27)
    }

}
