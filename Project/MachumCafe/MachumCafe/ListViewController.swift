//
//  ListViewController.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 4. 25..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    var getUserID = String()
    var getUserBookmarkArray = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        print(#function, "Table")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getUserID = User.sharedInstance.user.getUser()["id"] as! String
        getUserBookmarkArray = User.sharedInstance.user.getUser()["bookmark"] as! [String]
        tableView.reloadData()
    }
    
    
    func bookmarkToggleButton(_ buttonTag : UIButton) {
        print(buttonTag, buttonTag.tag)
        let cafeID = Cafe.sharedInstance.cafeList[buttonTag.tag].getCafe()["id"] as! String
        NetworkBookmark.setMyBookmark(userId: getUserID, cafeId: cafeID) { (message, des) in
            print(des)
            if message {
                NetworkBookmark.getMyBookmark(userId: self.getUserID, callback: { (message, cafe, userBookmark) in
                    Cafe.sharedInstance.bookmarkList = cafe
                    User.sharedInstance.user.setBookmark(bookmarks: userBookmark)
                    self.getUserBookmarkArray = User.sharedInstance.user.getUser()["bookmark"] as! [String]
                    print(User.sharedInstance.user.getUser()["bookmark"]!)
                })
                buttonTag.isSelected = !buttonTag.isSelected
            } else {
                UIAlertController().presentSuggestionLogInAlert(target: self, title: "즐겨찾기 오류", message: "로그인 후 이용해주세요")
            }
        }
    }
    
}

extension ListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cafe.sharedInstance.cafeList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListTableViewCell
        let cafeData = Cafe.sharedInstance.cafeList[indexPath.row].getCafe()
        var imagesData = cafeData["imagesData"] as! [Data]
        
        cell.backgroundImageView.image = UIImage(data: imagesData[0])
        cell.cafeNameLabel.text = cafeData["name"] as? String
        cell.cafeAddressLabel.text = cafeData["address"] as? String
        cell.distanceLabel.text = "1.2km"
        
        cell.bookmarkButton.isSelected = getUserBookmarkArray.contains(cafeData["id"] as! String) ? true : false
        cell.bookmarkButton.tag = indexPath.row
        cell.bookmarkButton.addTarget(self, action: #selector(bookmarkToggleButton(_:)), for: .touchUpInside)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailView" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! CafeDetailViewController
                controller.cafeData = Cafe.sharedInstance.cafeList[indexPath.row].getCafe()
            }
        }
    }
    
}
