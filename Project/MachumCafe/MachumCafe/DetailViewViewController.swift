//
//  DetailViewViewController.swift
//  MachumCafe
//
//  Created by HannaJeon on 2017. 9. 25..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class DetailViewViewController: UIViewController {

    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var cafeImageScrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var cafeNameLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var showMoreReview: UIButton!
    
    var cafeData = [String:Any]()
    var currentCafeModel = ModelCafe()
    var cafeCategorys = [String]()
    var reviews = [ModelReview]()
    var ratingViewxib = Bundle.main.loadNibNamed("RatingView", owner: self, options: nil)?.first as! RatingView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.allowsSelection = false
        
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.separatorColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2)
        detailTableView.separatorInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        
        cafeData = currentCafeModel.getCafe()
        cafeCategorys = cafeData["category"] as! [String]
        NetworkCafe.getCafeReviews(cafeModel: currentCafeModel)
        
        if !(cafeData["imagesURL"] as! [String]).isEmpty {
            makeCafeImageScrollView(imagesURL: cafeData["imagesURL"] as! [String])
        } else {
            cafeImageScrollView.addSubview(UIImageView(image: #imageLiteral(resourceName: "2")))
        }
        
        cafeNameLabel.text = cafeData["name"] as? String
        cafeNameLabel.sizeToFit()
        ratingViewxib.ratingLabel.text = String(describing: cafeData["rating"]!)
        ratingViewxib.ratingStarImage.image = String(describing: cafeData["rating"]!) == "0.0" ? #imageLiteral(resourceName: "RatingStarEmpty") : #imageLiteral(resourceName: "RatingStarFill")
        ratingViewxib.frame.origin.x = UIScreen.main.bounds.maxX - ratingViewxib.frame.width - 15
        ratingViewxib.center.y = cafeNameLabel.center.y
        containerView.addSubview(ratingViewxib)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadReviewTable), name: NSNotification.Name(rawValue: "refreshReview"), object: nil)
    }
    
    func reloadReviewTable(_ notification: Notification) {
        reviews += currentCafeModel.getReviews()
        detailTableView.reloadData()
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
    
    func suggestionButtonAction() {
        let suggestionViewController = UIStoryboard.SuggestionViewStoryboard.instantiateViewController(withIdentifier: "Suggestion") as! SuggestionViewController
        let suggestionViewNavigationController = UINavigationController(rootViewController: suggestionViewController)
        suggestionViewController.cafeData = cafeData
        present(suggestionViewNavigationController, animated: true, completion: nil)
    }
    
    func phoneCallButtonAction() {
        if let url = URL(string: "tel://\(cafeData["tel"] as? String ?? "")") {
            UIApplication.shared.open(url)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let writeReviewView : WriteReviewViewController = (segue.destination as? WriteReviewViewController)!
        writeReviewView.currentCafeModel = currentCafeModel
    }
}

extension DetailViewViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return reviews.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 53 * 3
        } else {
            detailTableView.estimatedRowHeight = 50
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CafeDetailTableViewCell
            
            if let address = cafeData["address"] as? String {
                cell.suggestionButton[0].isHidden = true
                cell.detailLabel[0].text = address
            }
            if let tel = cafeData["tel"] as? String {
                cell.suggestionButton[1].isHidden = true
                cell.detailLabel[1].text = tel
            }
            if let hours = cafeData["hours"] as? String {
                cell.suggestionButton[2].isHidden = true
                cell.detailLabel[2].text = hours
                cell.phoneCallButton.isHidden = false
            }
            cell.suggestionButton.forEach { button in
                button.addTarget(self, action: #selector(suggestionButtonAction), for: .touchUpInside)
            }
            cell.phoneCallButton.addTarget(self, action: #selector(phoneCallButtonAction), for: .touchUpInside)
            return cell
        } else {
            let reviewTableViewCellNib = UINib(nibName: "ReviewTableViewCell", bundle: nil)
            detailTableView.register(reviewTableViewCellNib, forCellReuseIdentifier: "Cell")
            
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

extension DetailViewViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cafeCategorys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let filterCollectionViewCellnib = UINib(nibName: "FilterCollectionViewCell", bundle: nil)
        categoryCollectionView.register(filterCollectionViewCellnib, forCellWithReuseIdentifier: "Cell")
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FilterCollectionViewCell
        cell.category.text = cafeCategorys[indexPath.item]
        
        let originalHeight = categoryCollectionView.frame.height
        categoryCollectionView.frame.size.height = categoryCollectionView.contentSize.height
        containerView.frame.size.height = containerView.frame.height - (originalHeight - categoryCollectionView.frame.height)
        detailTableView.reloadData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 11, left: 3, bottom: 11, right: 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = cafeCategorys[indexPath.item].unicodeScalars.count * 15 + 8
        return CGSize(width: width, height: 25)
    }
    
}

