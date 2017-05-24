
//  cafedetailViewController.swift
//  MachumCafe_Practice
//
//  Created by Danb on 2017. 4. 24..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class CafeDetailViewController: UIViewController {
    
    var currentCafeModel = ModelCafe()
    var cafeData = [String:Any]()
    var reviews = [ModelReview]()
    var indexCafeID = String()
    var userID = String()
    var userBookmarkIDs = [String]()

    
    @IBOutlet weak var cafeNameLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var reviewHeight: NSLayoutConstraint!
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var cafeImageView: UIImageView!
    @IBOutlet weak var moreReviewButton: UIButton!
    
    let cafeIcon = [#imageLiteral(resourceName: "telephoneD"),#imageLiteral(resourceName: "adressD"),#imageLiteral(resourceName: "hourD")]
    let reviewer = ["구제이", "한나", "메이플"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTableView.delegate = self
        detailTableView.dataSource = self
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        
        cafeData = currentCafeModel.getCafe()
        
        //TODO: 카페 리뷰는 카페디테일 들어갈때마다 GET해옴
        NetworkCafe.getCafeReviews(cafeModel: currentCafeModel)
        
        let imagesData = cafeData["imagesData"] as? [Data]
        navigationItem.title = cafeData["name"] as? String
        cafeNameLabel.text = cafeData["name"] as? String
//        cafeImageView.image = UIImage(data: (imagesData?[0])!)
        bookmarkButton.addTarget(self, action: #selector(bookmarkToggleButton), for: .touchUpInside)
        viewInit()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadReviewTable), name: NSNotification.Name(rawValue: "refreshReview"), object: nil)
    }

    
    func reloadReviewTable() {
        self.reviews = self.currentCafeModel.getReviews()
        self.reviewTableView.reloadData()
        print("♻︎♻︎")
        // 리뷰 작성 또는 viewDidLoad시 마다 호출
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // UserBookmark 정보 불러오기
        userID = User.sharedInstance.user.getUser()["id"] as! String
        userBookmarkIDs = User.sharedInstance.user.getUser()["bookmark"] as! [String]
        indexCafeID = cafeData["id"] as! String
        bookmarkButton.isSelected = userBookmarkIDs.contains(indexCafeID) ? true : false
        
        //테이블뷰 높이 오토레이아웃 설정
        let cell = detailTableView.dequeueReusableCell(withIdentifier: "Cell") as! CafeDetailCategoryTableViewCell
        tableViewHeight.constant = CGFloat(Double(3) * Double(detailTableView.rowHeight) + Double(cell.frame.height))
        reviewHeight.constant = CGFloat(3.0 * reviewTableView.rowHeight)
        self.view.layoutIfNeeded()
    }
    
    func viewInit() {
        moreReviewButton.layer.cornerRadius = 5
        moreReviewButton.setTitle("리뷰 더 보기", for: .normal)
        detailTableView.separatorInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        detailTableView.isScrollEnabled = false
        reviewTableView.isScrollEnabled = false
        bookmarkButton.setImage(#imageLiteral(resourceName: "Bookmark_Bt"), for: .normal)
        bookmarkButton.setImage(#imageLiteral(resourceName: "Bookmarked_Bt"), for: .selected)
        cafeNameLabel.sizeToFit()
    }
    
    func bookmarkToggleButton() {
        NetworkBookmark.setMyBookmark(userId: userID, cafeId: indexCafeID) { (result, des) in
            print(des)
            if result {
                self.bookmarkButton.isSelected = !self.bookmarkButton.isSelected
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadBookmark"), object: nil)
            } else {
                UIAlertController().presentSuggestionLogInAlert(target: self, title: "즐겨찾기", message: "로그인 후 이용해주세요.")
            }
        }
    }
    

    
    @IBAction func shareActionButton(_ sender: Any) {
      //  let detailURL =
        let activityVC = UIActivityViewController(activityItems: ["www"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
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
            return reviews.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CafeDetailTableViewCell
            cell.detailLabel.sizeToFit()
            
            if indexPath.row == 0 {
                cell.iconImage.image = cafeIcon[0]
                cell.detailLabel.text = cafeData["tel"] as? String
            }
            
            if indexPath.row == 1 {
                cell.iconImage.image = cafeIcon[1]
                cell.detailLabel.text = cafeData["address"] as? String
            }
            
            if indexPath.row == 2 {
                cell.iconImage.image = cafeIcon[2]
                cell.detailLabel.text = cafeData["hours"] as? String
            }
            
            if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CafeDetailCategoryTableViewCell
                cell.categoryIcon1.image = #imageLiteral(resourceName: "parkingCategoryIcon") as UIImage
                cell.categoryIcon2.image = #imageLiteral(resourceName: "smokingCategoryIcon") as UIImage
                cell.categoryIcon3.image = #imageLiteral(resourceName: "restroomCategoryIcon") as UIImage
                return cell
            }
            return cell
            }
            
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CafeDetailReviewTableViewCell
            if !reviews.isEmpty {
                let review = reviews[indexPath.row].getReview()
                cell.reviewerNickName.text = review["nickname"] as? String
                cell.reviewDescribe.text = review["reviewContent"] as? String
                cell.reviewProfil.image = #imageLiteral(resourceName: "profil_side")
            }
            return cell
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let reviewView : ReviewViewController = (segue.destination as? ReviewViewController)!
        reviewView.currentCafeModel = currentCafeModel
    }
}
