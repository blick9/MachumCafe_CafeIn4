//
//  ListViewController.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 4. 25..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit
import CoreLocation

class ListViewController: UIViewController {
    var getUserID = String()
    var getUserBookmarkArray = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var isEmptyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: NSNotification.Name(rawValue: "reloadTableView"), object: nil)

        print(#function, "Table")
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getUserID = User.sharedInstance.user.getUser()["id"] as! String
        getUserBookmarkArray = User.sharedInstance.user.getUser()["bookmark"] as! [String]
        reloadTableView()
    }
    
    func displayEmptyLabel() {
        if Cafe.sharedInstance.filterCafeList.isEmpty {
            isEmptyLabel.text = "카페 정보 없음"
            tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        } else {
            isEmptyLabel.text = ""
            tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        }
    }
    
    
    func bookmarkToggleButton(_ buttonTag : UIButton) {
        let cafeID = Cafe.sharedInstance.filterCafeList[buttonTag.tag].getCafe()["id"] as! String
        NetworkBookmark.setMyBookmark(userId: getUserID, cafeId: cafeID) { (result, des) in
            print(des)
            if User.sharedInstance.isUser {
                self.getUserBookmarkArray = User.sharedInstance.user.getUser()["bookmark"] as! [String]
                print(User.sharedInstance.user.getUser()["bookmark"]!)
                buttonTag.isSelected = !buttonTag.isSelected
            } else {
                UIAlertController().presentSuggestionLogInAlert(target: self, title: "즐겨찾기", message: "로그인 후 이용해주세요")
            }
        }
    }
    
    func reloadTableView() {
        tableView.reloadData()
        displayEmptyLabel()
    }
    
}

extension ListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cafe.sharedInstance.filterCafeList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListTableViewCell
        var cafe = Cafe.sharedInstance.filterCafeList[indexPath.row].getCafe()
        
        let currentLocation = CLLocation(latitude: Location.sharedInstance.currentLocation.getLocation()["latitude"] as! Double , longitude: Location.sharedInstance.currentLocation.getLocation()["longitude"] as! Double)
        
        let cafeLocation = CLLocation(latitude: cafe["latitude"] as! CLLocationDegrees, longitude: cafe["longitude"] as! CLLocationDegrees)
        
        let distanceInMeters = currentLocation.distance(from: cafeLocation) 
        
        if (cafe["imagesData"] as! [Data]).isEmpty {
            NetworkCafe.getImagesData(imagesURL: cafe["imagesURL"] as! [String]) { (data) in
                Cafe.sharedInstance.filterCafeList[indexPath.row].setImagesData(imageData: data)
                cafe = Cafe.sharedInstance.filterCafeList[indexPath.row].getCafe()
                cell.backgroundImageView.image = UIImage(data: (cafe["imagesData"] as! [Data])[0])
            }
        } else {
            cell.backgroundImageView.image = UIImage(data: (cafe["imagesData"] as! [Data])[0])
        }

        cell.cafeNameLabel.text = cafe["name"] as? String
        cell.cafeAddressLabel.text = cafe["address"] as? String
        cell.distanceLabel.text = "\(Int(distanceInMeters))M"
        
        cell.bookmarkButton.isSelected = getUserBookmarkArray.contains(cafe["id"] as! String) ? true : false
        cell.bookmarkButton.tag = indexPath.row
        cell.bookmarkButton.addTarget(self, action: #selector(bookmarkToggleButton(_:)), for: .touchUpInside)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailView" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! CafeDetailViewController
                controller.currentCafeModel = Cafe.sharedInstance.filterCafeList[indexPath.row]
            }
        }
    }
    
}
