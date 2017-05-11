//
//  ListContainerViewController.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 4. 25..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit


class ListContainerViewController: UIViewController {
    let listViewStoryboard = UIStoryboard(name: "ListView", bundle: nil)
    let listMapViewStoryboard = UIStoryboard(name: "ListMapView", bundle: nil)
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

        listTableViewController = listViewStoryboard.instantiateViewController(withIdentifier: "ListView")
        listMapViewController = listMapViewStoryboard.instantiateViewController(withIdentifier: "ListMap")
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
        let filterStoryboard = UIStoryboard(name: "FilterView", bundle: nil)
        let filterViewController = filterStoryboard.instantiateViewController(withIdentifier: "FilterView")
        present(filterViewController, animated: true, completion: nil)
    }
}
