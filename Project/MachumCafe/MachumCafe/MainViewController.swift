//
//  MainViewController.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 4. 25..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIScrollViewDelegate {
    
    var bannerArray = [UIImage]()
    var filterArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)

        
        if let locationLabelxib = Bundle.main.loadNibNamed("LocationLabelView", owner: self, options: nil)?.first as? LocationLabelView {
            locationLabelxib.delegate = self
            locationLabelxib.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: locationLabelxib.frame.height)
            self.view.addSubview(locationLabelxib)
        }
    }

    @IBAction func sideBarShowButtonAction(_ sender: Any) {
        let sideBarViewController = UIStoryboard.MainViewStoryboard.instantiateViewController(withIdentifier: "SideBar")
        present(sideBarViewController, animated: false, completion: nil)
    }
    
    @IBAction func categoryButtons(_ sender: UIButton) {
        let listContainerViewController = UIStoryboard.ListContainerViewStoryboard.instantiateViewController(withIdentifier: "ListContainer") as! ListContainerViewController
        navigationController?.pushViewController(listContainerViewController, animated: true)
        
        var element : String?
        switch sender.tag {
        case 0:
            element = nil
        case 1:
            element = "24시"
        case 2:
            element = "주차"
        case 3:
            element = "디저트"
        case 4:
            element = "로스팅"
        case 5:
            element = "미팅룸"
        default:
            break
        }
        
        if let value = element {
            listContainerViewController.selectedFilterArray.append(value)
        }
    }
    
    @IBAction func presentFilterViewButtonAction(_ sender: Any) {
        let listContainerViewController = UIStoryboard.ListContainerViewStoryboard.instantiateViewController(withIdentifier: "ListContainer") as! ListContainerViewController
        navigationController?.pushViewController(listContainerViewController, animated: false)
        listContainerViewController.showFilterView()
    }
    
}
