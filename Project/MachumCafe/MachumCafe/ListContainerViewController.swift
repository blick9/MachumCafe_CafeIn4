//
//  ListContainerViewController.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 4. 25..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class ListContainerViewController: UIViewController {
    @IBOutlet weak var listMapView: UIView!
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var viewSwitchButtonItem: UIBarButtonItem!
    
    var isMapView = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "맞춤카페 목록"
        //TODO:- 초기화될 때 Map View 없애기. 동시에 생겨 불필요함
//        listMapView.removeFromSuperview()
        
        //TODO:- < 버튼 옆 Text 없애기
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        print(#function, "Container")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)

    }
    
    @IBAction func listViewSwitchToggleButtonAction(_ sender: Any) {
        if isMapView {
            listMapView.removeFromSuperview()
            view.addSubview(listView)
            viewSwitchButtonItem.image = #imageLiteral(resourceName: "map_Bt")
        } else {
            listView.removeFromSuperview()
            view.addSubview(listMapView)
            viewSwitchButtonItem.image = #imageLiteral(resourceName: "list_Bt")
        }
        isMapView = !isMapView
    }

    @IBAction func showFilterViewButtonItem(_ sender: Any) {
        let filterStoryboard = UIStoryboard(name: "FilterView", bundle: nil)
        let filterViewController = filterStoryboard.instantiateViewController(withIdentifier: "FilterView")
        present(filterViewController, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
