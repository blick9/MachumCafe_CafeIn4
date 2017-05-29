
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
    var cafeCategorys = [String]()
    var reviews = [ModelReview]()
    var indexCafeID = String()
    var userID = String()
    var userBookmarkIDs = [String]()
    let reviewTableViewCellNib = UINib(nibName: "ReviewTableViewCell", bundle: nil)
    let nib = UINib(nibName: "FilterCollectionViewCell", bundle: nil)
    
    @IBOutlet weak var cafeNameLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var reviewHeight: NSLayoutConstraint!
    @IBOutlet weak var categoryCollectionHeight: NSLayoutConstraint!
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var moreReviewButton: UIButton!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var cafeImageScrollView: UIScrollView!

    let cafeIcon = [#imageLiteral(resourceName: "adressD"),#imageLiteral(resourceName: "telephoneD"), #imageLiteral(resourceName: "hourD")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.allowsSelection = false
    
        detailTableView.delegate = self
        detailTableView.dataSource = self
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        reviewTableView.register(reviewTableViewCellNib, forCellReuseIdentifier: "Cell")
        let moreButton = UIBarButtonItem(image: #imageLiteral(resourceName: "more_Bt"), style: .plain, target: self, action: #selector(moreButtonAction))
        navigationItem.rightBarButtonItem = moreButton
       // categoryCollectionView.isScrollEnabled = false
        categoryCollectionView.register(nib, forCellWithReuseIdentifier: "Cell")
        cafeData = currentCafeModel.getCafe()
        cafeCategorys = cafeData["category"] as! [String]
        
        //TODO: 카페 리뷰는 카페디테일 들어갈때마다 GET해옴
        NetworkCafe.getCafeReviews(cafeModel: currentCafeModel)
        if !(cafeData["imagesData"] as! [Data]).isEmpty {
            makeCafeImageScrollView(imagesData: cafeData["imagesData"] as! [Data])
        } else {
            cafeImageScrollView.addSubview(UIImageView(image: #imageLiteral(resourceName: "1")))
        }
        
        navigationItem.title = cafeData["name"] as? String
        cafeNameLabel.text = cafeData["name"] as? String
        bookmarkButton.addTarget(self, action: #selector(bookmarkToggleButton), for: .touchUpInside)
        viewInit()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadReviewTable), name: NSNotification.Name(rawValue: "refreshReview"), object: nil)
    }
    
    func moreButtonAction() {
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let reportEditAction = UIAlertAction(title: "수정 제보", style: .default) { _ in
            self.suggestionButtonAction()
        }
        let reportCloseAction = UIAlertAction(title: "폐업 신고", style: .destructive) { _ in
            //TODO: 폐업 신고 Network 메서드 구현
            print("폐업 신고")
        }
        let closeAction = UIAlertAction(title: "닫기", style: .cancel) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        actionSheetController.addAction(reportEditAction)
        actionSheetController.addAction(reportCloseAction)
        actionSheetController.addAction(closeAction)
        present(actionSheetController, animated: true, completion: nil)
    }
    
    func reloadReviewTable() {
        self.reviews = self.currentCafeModel.getReviews()
        self.reviewTableView.reloadData()
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
        tableViewHeight.constant = CGFloat(Double(3) * Double(detailTableView.rowHeight))
        reviewHeight.constant = CGFloat(3.0 * reviewTableView.rowHeight)
        //카테고리 높이 오토레이아웃 설정
        if cafeCategorys.count > 5 {
            categoryCollectionHeight.constant = CGFloat(1.7 * categoryCollectionView.frame.height)
        }
        self.view.layoutIfNeeded()
    }
    
    func viewInit() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        moreReviewButton.layer.cornerRadius = 5
        moreReviewButton.setTitle("리뷰 더 보기", for: .normal)
        detailTableView.separatorInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        detailTableView.isScrollEnabled = false
        reviewTableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        reviewTableView.isScrollEnabled = false
        bookmarkButton.setImage(#imageLiteral(resourceName: "Bookmark_Bt"), for: .normal)
        bookmarkButton.setImage(#imageLiteral(resourceName: "Bookmarked_Bt"), for: .selected)
        cafeNameLabel.sizeToFit()
    }
    
    func makeCafeImageScrollView(imagesData: [Data]) {
        for i in 0..<imagesData.count {
            let cafeImage = UIImageView()
            cafeImage.contentMode = .scaleAspectFill
            cafeImage.image = UIImage(data: imagesData[i])
            let xPosition = self.view.frame.width * CGFloat(i)
            cafeImage.frame = CGRect(x: xPosition, y: 0, width: self.cafeImageScrollView.frame.width, height: self.cafeImageScrollView.frame.height)
            cafeImageScrollView.contentSize.width = cafeImageScrollView.frame.width * CGFloat(i+1)
            cafeImageScrollView.addSubview(cafeImage)
        }
    }
    
    func bookmarkToggleButton() {
        if User.sharedInstance.isUser {
            NetworkBookmark.setMyBookmark(userId: userID, cafeId: indexCafeID, callback: { (desc) in
                print(desc)
                self.bookmarkButton.isSelected = !self.bookmarkButton.isSelected
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadBookmark"), object: nil)
            })
        } else {
            UIAlertController().presentSuggestionLogInAlert(target: self, title: "즐겨찾기", message: "로그인 후 이용해주세요.")

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let reviewView : ReviewViewController = (segue.destination as? ReviewViewController)!
        reviewView.currentCafeModel = currentCafeModel
    }
    
    func suggestionButtonAction() {
        let suggestionViewController = UIStoryboard.SuggestionViewStoryboard.instantiateViewController(withIdentifier: "Suggestion") as! SuggestionViewController
        let suggestionViewNavigationController = UINavigationController(rootViewController: suggestionViewController)
        suggestionViewController.cafeData = cafeData
        present(suggestionViewNavigationController, animated: true, completion: nil)
    }
    func phoneCallButtonAction() {
        let url = NSURL(string: "tel://\(cafeData["tel"] as! String)")
        UIApplication.shared.openURL(url as! URL)
        print("CCCCCLLLLLCCCCLLLLLLCCCCLLLL")
        print(url)

    }
}

extension CafeDetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 1 {
            return 53
        } else {
            return 130
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
            return 3
        } else {
            return reviews.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CafeDetailTableViewCell
            cell.detailLabel.sizeToFit()

            if indexPath.row == 0 {
                cell.iconImage.image = cafeIcon[0]
                if let address = cafeData["address"] as? String {
                    cell.suggestionButton.isHidden = true
                    cell.phoneCallButton.isHidden = true
                    cell.detailLabel.text = address
                }
            } else if indexPath.row == 1 {
                cell.iconImage.image = cafeIcon[1]
                if let tel = cafeData["tel"] as? String {
                    cell.suggestionButton.isHidden = true
                    cell.detailLabel.text = tel
                }
            } else if indexPath.row == 2 {
                cell.iconImage.image = cafeIcon[2]
                if let hours = cafeData["hours"] as? String {
                    cell.suggestionButton.isHidden = true
                    cell.detailLabel.text = hours
                }
                cell.phoneCallButton.isHidden = true
            }
            cell.suggestionButton.addTarget(self, action: #selector(suggestionButtonAction), for: .touchUpInside)
            cell.phoneCallButton.addTarget(self, action: #selector(phoneCallButtonAction), for: .touchUpInside)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ReviewTableViewCell
            if !reviews.isEmpty {
                var review = reviews[indexPath.row].getReview()
                
                cell.reviewer.text = review["nickname"] as? String
                cell.reviewDate.text = review["date"] as? String
                cell.reviewContent.text = review["reviewContent"] as? String
                cell.reviewStarRating.rating = review["rating"] as! Double
                
                if !(review["profileImageURL"] as! String).isEmpty {
                    NetworkUser.getUserImage(userID: review["userId"] as? String, isKakaoImage: review["isKakaoImage"] as! Bool, imageURL: review["profileImageURL"] as! String) { (profileImageData) in
                        self.reviews[indexPath.row].setProfileImage(profileImage: profileImageData)
                        review = self.reviews[indexPath.row].getReview()
                        cell.reviewerPicture.image = UIImage(data: review["profileImage"] as! Data)
                    }
                } else {
                    cell.reviewerPicture.image = #imageLiteral(resourceName: "profil_side")
                }
            }
            return cell
        }
    }
}

extension CafeDetailViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cafeCategorys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FilterCollectionViewCell
        cell.category.text = cafeCategorys[indexPath.row]
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 3, bottom: 5, right: 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Double((cafeCategorys[indexPath.row] as String).unicodeScalars.count) * 15.0 + 8
        return CGSize(width: width, height: 25)
    }
}
