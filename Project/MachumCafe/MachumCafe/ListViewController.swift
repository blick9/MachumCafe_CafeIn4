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
    var currentLocation = CLLocation()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var isEmptyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: NSNotification.Name(rawValue: "reloadTableView"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getUserID = User.sharedInstance.user.id
        getUserBookmarkArray = User.sharedInstance.user.bookmark
        currentLocation = CLLocation(latitude: Location.sharedInstance.currentLocation.latitude, longitude: Location.sharedInstance.currentLocation.longitude)
        
        displayEmptyLabel()
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
        guard let cafeID = Cafe.sharedInstance.filterCafeList[buttonTag.tag].id else { return }
        if User.sharedInstance.isUser {
            NetworkBookmark.setMyBookmark(userId: getUserID, cafeId: cafeID, callback: { (desc) in
                print(desc)
                self.getUserBookmarkArray = User.sharedInstance.user.bookmark
                print(User.sharedInstance.user.bookmark)
                buttonTag.isSelected = !buttonTag.isSelected
            })
        } else {
            UIAlertController().presentSuggestionLogInAlert(target: self, title: "즐겨찾기", message: "로그인 후 이용해주세요")
        }
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailView" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! DetailViewViewController
                controller.cafe = Cafe.sharedInstance.filterCafeList[indexPath.row]
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        clearMemory()
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
        let cafe = Cafe.sharedInstance.filterCafeList[indexPath.row]
        
        if let latitude = cafe.latitude,
            let longitude = cafe.longitude {
            let cafeLocation = CLLocation(latitude: latitude, longitude: longitude)
            var distance = Double(currentLocation.distance(from: cafeLocation))
            let convertByDistance = distance.meterConvertToKiloMeter(places: 2)
            cell.distanceLabel.text = "\(distance > 1000 ? "\(convertByDistance)km" : "\(Int(convertByDistance))m")"
        }
        
        if !cafe.imagesURL.isEmpty {
            let cafeImage = NetworkCafe.getCafeImage(imageURL: cafe.imagesURL[0])
            cell.backgroundImageView.kf.setImage(with: cafeImage)
        } else {
            cell.backgroundImageView.image = #imageLiteral(resourceName: "2")
        }
        cell.cafeNameLabel.text = cafe.name
        cell.cafeAddressLabel.text = cafe.address
        cell.ratingValue = String(describing: cafe.rating)
        
        if !cafe.category.isEmpty {
            let categorylabel = cafe.category.reduce("") { $0 + "#\($1) " }
            cell.category.text = categorylabel
        }
        
        if let id = cafe.id {
            cell.bookmarkButton.isSelected = getUserBookmarkArray.contains(id) ? true : false
        }
        cell.bookmarkButton.tag = indexPath.row
        cell.bookmarkButton.addTarget(self, action: #selector(bookmarkToggleButton(_:)), for: .touchUpInside)
        return cell
    }
}
