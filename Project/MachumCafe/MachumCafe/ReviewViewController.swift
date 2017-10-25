//
//  ReviewViewController.swift
//  MachumCafe
//
//  Created by   minjae on 2017. 5. 15..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    
    var currentCafeModel = ModelCafe()
    var reviews = [ModelReview]()
    let reviewTableViewCellNib = UINib(nibName: "ReviewTableViewCell", bundle: nil)
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "카페 리뷰"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.register(reviewTableViewCellNib, forCellReuseIdentifier: "Cell")
        reviews = currentCafeModel.getReviews()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadReviewTable), name: NSNotification.Name(rawValue: "refreshReview"), object: nil)
    }
    
    func reloadReviewTable() {
        reviews = currentCafeModel.getReviews()
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let writeReviewView : WriteReviewViewController = (segue.destination as? WriteReviewViewController)!
        writeReviewView.currentCafeModel = currentCafeModel
    }
}

extension ReviewViewController : UITableViewDelegate, UITableViewDataSource { 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ReviewTableViewCell
        
        var review = reviews[indexPath.row].getReview()
        cell.reviewer.text = review["nickname"] as? String
        cell.reviewDate.text = review["date"] as? String
        cell.reviewContent.text = review["reviewContent"] as? String
        cell.reviewStarRating.rating = review["rating"] as! Double
        if !(review["profileImageURL"] as! String).isEmpty {
            let profileImage = NetworkUser.getUserImage(userID: review["userId"] as! String, isKakaoImage: review["isKakaoImage"] as! Bool, imageURL: review["profileImageURL"] as! String)
                cell.reviewerPicture.kf.setImage(with: profileImage)
                cell.reviewerPicture.layer.masksToBounds = true
                cell.reviewerPicture.layer.cornerRadius = CGFloat(cell.reviewerPicture.frame.height / 2)
        } else {
            cell.reviewerPicture.image = #imageLiteral(resourceName: "profil_side")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }
}

