
//  cafedetailViewController.swift
//  MachumCafe_Practice
//
//  Created by Danb on 2017. 4. 24..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class CafeDetailViewController: UIViewController {
    
    var cafeModel = ModelCafe()
    var cafeData = [String:Any]()
    var getUserID = String()
    var getUserBookmarkArray = [String]()
    var indexCafeID = String()
    

    @IBOutlet weak var cafeNameLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var reviewHeight: NSLayoutConstraint!
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var cafeImageView: UIImageView!
 //  @IBOutlet weak var reviewMoreButton: UIButton!
    
    let cafeIcon = [#imageLiteral(resourceName: "telephoneD"),#imageLiteral(resourceName: "adressD"),#imageLiteral(resourceName: "hourD")]
    let reviewer = ["구제이", "한나", "메이플"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cafeData = cafeModel.getCafe()
        let imagesData = cafeData["imagesData"] as? [Data]
        print(imagesData)

        navigationItem.title = cafeData["name"] as? String
        cafeNameLabel.text = cafeData["name"] as? String
//        cafeImageView.image = UIImage(data: (imagesData?[0])!)
        bookmarkButton.addTarget(self, action: #selector(bookmarkToggleButton), for: .touchUpInside)
        viewInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // UserBookmark 정보 불러오기
        getUserID = User.sharedInstance.user.getUser()["id"] as! String
        getUserBookmarkArray = User.sharedInstance.user.getUser()["bookmark"] as! [String]
        indexCafeID = cafeData["id"] as! String
        bookmarkButton.isSelected = getUserBookmarkArray.contains(indexCafeID) ? true : false
        
        //테이블뷰 높이 오토레이아웃 설정
        let cell = detailTableView.dequeueReusableCell(withIdentifier: "Cell") as! CafeDetailCategoryTableViewCell
        tableViewHeight.constant = CGFloat(Double(3) * Double(detailTableView.rowHeight) + Double(cell.frame.height))
        reviewHeight.constant = CGFloat(3.0 * reviewTableView.rowHeight)
        self.view.layoutIfNeeded()
    }
    
    func viewInit() {
        detailTableView.separatorInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        detailTableView.isScrollEnabled = false
        reviewTableView.isScrollEnabled = false
        bookmarkButton.setImage(#imageLiteral(resourceName: "Bookmark_Bt"), for: .normal)
        bookmarkButton.setImage(#imageLiteral(resourceName: "Bookmarked_Bt"), for: .selected)
        cafeNameLabel.sizeToFit()
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
                UIAlertController().presentSuggestionLogInAlert(target: self, title: "즐겨찾기", message: "로그인 후 이용해주세요.")
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loadReview(_ sender: Any) {
        print("이게 리뷰댜")
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
                cell.detailLabel.text = cafeData["tel"] as? String
            }
            
            if indexPath.row == 1 {
                cell.detailLabel.text = cafeData["address"] as? String
            }
            
            if indexPath.row == 2 {
                cell.detailLabel.text = cafeData["hours"] as? String
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
