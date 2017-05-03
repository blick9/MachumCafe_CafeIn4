
//  cafedetailViewController.swift
//  MachumCafe_Practice
//
//  Created by Danb on 2017. 4. 24..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class CafeDetailViewController: UIViewController {
    
    var index = Int()
    var getUserID = String()
    var getUserBookmarkArray = [String]()
    var indexCafeID = String()
    
    @IBOutlet weak var detailCategoryCell: UIView!
    @IBOutlet weak var cafeNameLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var reviewHeight: NSLayoutConstraint!
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var reviewTableView: UITableView!
    
 //  @IBOutlet weak var reviewMoreButton: UIButton!
    
    let cafeName = ["02-512-2395", "서울특별시 강남구 도산대로67길 13-12(청담동)","평일 AM 11:00 ~ AM 01:00","주차 가능","매장 내 위치","주차 가능","매장 내 위치"]
    let cafeIcon = [#imageLiteral(resourceName: "telephoneD"),#imageLiteral(resourceName: "adressD"),#imageLiteral(resourceName: "hourD")]
    
    let reviewer = ["구제이", "한나", "메이플"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewInit()
        detailTableView.separatorInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        detailTableView.isScrollEnabled = false
        reviewTableView.isScrollEnabled = false
        cafeNameLabel.sizeToFit()
        
        //dump(Cafe.sharedInstance.cafeList[1].getCafe())

        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // UserBookmark 정보 불러오기
        getUserID = User.sharedInstance.user.getUser()["id"] as! String
        getUserBookmarkArray = User.sharedInstance.user.getUser()["bookmark"] as! [String]
        indexCafeID = Cafe.sharedInstance.cafeList[index].getCafe()["id"] as! String
        bookmarkButton.isSelected = getUserBookmarkArray.contains(indexCafeID) ? true : false
        
        tableViewHeight.constant = CGFloat(Double(3) * Double(detailTableView.rowHeight) + Double(detailCategoryCell.frame.size.height))
        reviewHeight.constant = CGFloat(3.0 * reviewTableView.rowHeight)
        self.view.layoutIfNeeded()
    }
    
    func viewInit() {
        bookmarkButton.setImage(#imageLiteral(resourceName: "Bookmark_Bt"), for: .normal)
        bookmarkButton.setImage(#imageLiteral(resourceName: "Bookmarked_Bt"), for: .selected)
        cafeNameLabel.text = Cafe.sharedInstance.cafeList[index].getCafe()["name"] as? String
        bookmarkButton.addTarget(self, action: #selector(bookmarkToggleButton), for: .touchUpInside)
    }
    
    func bookmarkToggleButton() {
        NetworkBookmark.setMyBookmark(userId: getUserID, cafeId: indexCafeID) { (message, des) in
            print(des)
            if message {
                NetworkBookmark.getMyBookmark(userId: self.getUserID, callback: { (message, cafe, userBookmark) in
                    Cafe.sharedInstance.bookmarkList = cafe
                    User.sharedInstance.user.setBookmark(bookmarks: userBookmark)
                })
                self.bookmarkButton.isSelected = !self.bookmarkButton.isSelected
            } else {
                UIAlertController().presentSuggestionLogInAlert(target: self, title: "즐겨찾기 오류", message: "로그인 후 이용해주세요.")
            }
        }
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CafeDetailViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 1 {
            if indexPath.row == 3 {
                return 75
            }
            else {
                return 53
            }
        }
        else {
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.tag == 1 {
            return 4
        }
            
        else {
            return reviewer.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CafeDetailTableViewCell
            cell.detailLabel.sizeToFit()
            if indexPath.row == 0 {
                cell.detailLabel.text = Cafe.sharedInstance.cafeList[index].getCafe()["phoneNumber"] as? String
            }
            if indexPath.row == 1 {
                cell.detailLabel.text = Cafe.sharedInstance.cafeList[index].getCafe()["address"] as? String
            }
            if indexPath.row == 2 {
                cell.detailLabel.text = Cafe.sharedInstance.cafeList[index].getCafe()["hours"] as? String
            }
            if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CafeDetailCategoryTableViewCell
                cell.categoryIcon1.image = #imageLiteral(resourceName: "parkingCategoryIcon") as UIImage
                cell.categoryIcon2.image = #imageLiteral(resourceName: "smokingCategoryIcon") as UIImage
                cell.categoryIcon3.image = #imageLiteral(resourceName: "restroomCategoryIcon") as UIImage
                return cell
            }

            cell.iconImage.image = cafeIcon[indexPath.row]
            return cell
            }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CafeDetailReviewTableViewCell
            cell.reviewerNickName.text = reviewer[indexPath.row]
            return cell
        }
    }
}
