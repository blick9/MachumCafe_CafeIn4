
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
    let filterCollectionViewCellnib = UINib(nibName: "FilterCollectionViewCell", bundle: nil)
    var ratingViewxib = Bundle.main.loadNibNamed("RatingView", owner: self, options: nil)?.first as! RatingView
    let cafeIcon = [#imageLiteral(resourceName: "adressD"),#imageLiteral(resourceName: "telephoneD"), #imageLiteral(resourceName: "hourD")]
    
    @IBOutlet weak var backgroundScrollView: UIScrollView!
    @IBOutlet weak var cafeNameLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var detailTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var reviewTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var categoryCollectionHeight: NSLayoutConstraint!
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var moreReviewButton: UIButton!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var cafeImageScrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewInit()
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.allowsSelection = false
    
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.separatorColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2)
        
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        reviewTableView.register(reviewTableViewCellNib, forCellReuseIdentifier: "Cell")
        
        let moreButton = UIBarButtonItem(image: #imageLiteral(resourceName: "more_Bt"), style: .plain, target: self, action: #selector(moreButtonAction))
        navigationItem.rightBarButtonItem = moreButton
        categoryCollectionView.register(filterCollectionViewCellnib, forCellWithReuseIdentifier: "Cell")
        
        cafeData = currentCafeModel.getCafe()
        cafeCategorys = cafeData["category"] as! [String]
        
//        NetworkCafe.getCafeReviews(cafeModel: currentCafeModel) {
//            self.applyReviewTableViewHeight()
//            if self.cafeCategorys.count >= 5 {
//                self.categoryCollectionHeight.constant = CGFloat(1.7 * self.categoryCollectionView.frame.height)
//            }
//            self.view.layoutIfNeeded()
//        }
        
        if !(cafeData["imagesURL"] as! [String]).isEmpty {
            makeCafeImageScrollView(imagesURL: cafeData["imagesURL"] as! [String])
        } else {
            cafeImageScrollView.addSubview(UIImageView(image: #imageLiteral(resourceName: "2")))
        }
        
        cafeNameLabel.text = cafeData["name"] as? String
        cafeNameLabel.sizeToFit()

        ratingViewxib.ratingLabel.text = String(describing: cafeData["rating"]!)
        ratingViewxib.ratingStarImage.image = String(describing: cafeData["rating"]!) == "0.0" ? #imageLiteral(resourceName: "RatingStarEmpty") : #imageLiteral(resourceName: "RatingStarFill")
        ratingViewxib.frame = CGRect(x: cafeNameLabel.frame.maxX + 5 , y: cafeNameLabel.frame.midY - 11, width: 44, height: 18)
        backgroundScrollView.addSubview(ratingViewxib)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadReviewTable), name: NSNotification.Name(rawValue: "refreshReview"), object: nil)
    }
    
    func applyReviewTableViewHeight() {
        var indexCount : Int {
            let reviewsCount = self.reviews.count
            return reviewsCount > 3 ? 3 : reviewsCount
        }
        setReviewTableViewHeight(count: indexCount)
    }
    
    func setReviewTableViewHeight(count: Int) {
        reviewTableViewHeight.constant = CGFloat(CGFloat(count) * self.reviewTableView.rowHeight)
    }
    
    func moreButtonAction() {
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let reportEditAction = UIAlertAction(title: "수정 제보", style: .default) { _ in
            self.suggestionButtonAction()
        }
        let reportCloseAction = UIAlertAction(title: "폐업 신고", style: .destructive) { _ in
            let alert = UIAlertController(title: "폐업 신고", message: "폐업 신고를 하시겠습니까?", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "취소", style: .default)
            let confirm = UIAlertAction(title: "확인", style: .default, handler: { (_) in
                NetworkAdmin.suggestionClesedCafe(cafe: self.cafeData)
                UIAlertController().oneButtonAlert(target: self, title: "제보 완료", message: "소중한 의견 감사합니다.\n빠른시간 내에 적용하겠습니다 :)", isHandler: false)
            })
            alert.addAction(confirm)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }
        let closeAction = UIAlertAction(title: "닫기", style: .cancel)
        actionSheetController.addAction(reportEditAction)
        actionSheetController.addAction(reportCloseAction)
        actionSheetController.addAction(closeAction)
        present(actionSheetController, animated: true, completion: nil)
    }
    
    func reloadReviewTable() {
        reviews = currentCafeModel.getReviews()
        applyReviewTableViewHeight()
        reviewTableView.reloadData()
    }
    
    @IBAction func shareActionButton(_ sender: Any) {
        let activityViewController = UIActivityViewController(activityItems: ["machumcafe://host/cafe/\(indexCafeID)"], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userID = User.sharedInstance.user.getUser()["id"] as! String
        userBookmarkIDs = User.sharedInstance.user.getUser()["bookmark"] as! [String]
        indexCafeID = cafeData["id"] as! String
        bookmarkButton.isSelected = userBookmarkIDs.contains(indexCafeID) ? true : false
    }
    
    func viewInit() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        moreReviewButton.layer.cornerRadius = 5
        cafeNameLabel.shadowOffset = CGSize(width: 1.5, height: 1.5)
        cafeNameLabel.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
        bookmarkButton.addTarget(self, action: #selector(bookmarkToggleButton), for: .touchUpInside)
        moreReviewButton.setTitle("리뷰 더 보기", for: .normal)
        detailTableView.separatorInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        detailTableView.isScrollEnabled = false
        reviewTableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        reviewTableView.isScrollEnabled = false
        bookmarkButton.setImage(#imageLiteral(resourceName: "Bookmark_Bt"), for: .normal)
        bookmarkButton.setImage(#imageLiteral(resourceName: "Bookmarked_Bt"), for: .selected)
    }
    
    func makeCafeImageScrollView(imagesURL: [String]) {
        for i in 0..<imagesURL.count {
            let cafeImageResource = NetworkCafe.getCafeImage(imageURL: imagesURL[i])
            let xPosition = self.view.frame.width * CGFloat(i)
            let cafeImage = UIImageView()
            cafeImage.kf.setImage(with: cafeImageResource)
            cafeImage.frame = CGRect(x: xPosition, y: 0, width: self.view.frame.width, height: self.cafeImageScrollView.frame.height)
            cafeImage.contentMode = .scaleAspectFill
            cafeImage.clipsToBounds = true
            cafeImageScrollView.addSubview(cafeImage)
            let blackLayer = UIView()
            blackLayer.backgroundColor = UIColor.black
            blackLayer.alpha = 0.1
            blackLayer.frame = CGRect(x: xPosition, y: 0, width: self.view.frame.width, height: self.cafeImageScrollView.frame.height)
            cafeImageScrollView.addSubview(blackLayer)
        }
        cafeImageScrollView.contentSize.width = view.frame.width * CGFloat(imagesURL.count)
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        clearMemory()
    }
}

extension CafeDetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == detailTableView {
            return 53
        } else {
            return reviewTableView.rowHeight
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == detailTableView {
            return 3
        } else {
            return reviews.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CafeDetailTableViewCell

//            if indexPath.row == 0 {
//                cell.iconImage.image = cafeIcon[0]
//                if let address = cafeData["address"] as? String {
//                    cell.suggestionButton.isHidden = true
//                    cell.phoneCallButton.isHidden = true
//                    cell.detailLabel.text = address
//                }
//            } else if indexPath.row == 1 {
//                cell.iconImage.image = cafeIcon[1]
//                if let tel = cafeData["tel"] as? String {
//                    cell.suggestionButton.isHidden = true
//                    cell.detailLabel.text = tel
//                }
//            } else if indexPath.row == 2 {
//                cell.iconImage.image = cafeIcon[2]
//                if let hours = cafeData["hours"] as? String {
//                    cell.suggestionButton.isHidden = true
//                    cell.detailLabel.text = hours
//                }
//                cell.phoneCallButton.isHidden = true
//            }
//            cell.suggestionButton.addTarget(self, action: #selector(suggestionButtonAction), for: .touchUpInside)
//            cell.phoneCallButton.addTarget(self, action: #selector(phoneCallButtonAction), for: .touchUpInside)
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
                    let profileImage = NetworkUser.getUserImage(userID: review["userId"] as! String, isKakaoImage: review["isKakaoImage"] as! Bool, imageURL: review["profileImageURL"] as! String)
                    cell.reviewerPicture.kf.setImage(with: profileImage)
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
