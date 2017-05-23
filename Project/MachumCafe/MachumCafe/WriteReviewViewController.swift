//
//  WriteReviewViewController.swift
//  MachumCafe
//
//  Created by   minjae on 2017. 5. 16..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit
import Cosmos

class WriteReviewViewController: UIViewController {

    @IBOutlet weak var writeReview: UITextView!
    @IBOutlet weak var starRating: CosmosView!
    
    var reviewView = ReviewViewController()
    
    var reviewDictionary = Review.sharedInstance.review.getReview()
    var user = User.sharedInstance.user.getUser()
    var cafe = Cafe.sharedInstance.allCafeList[1].getCafe() // 변경 필요
    var writtenDate = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        let year = NSCalendar.current.component(.year, from: Date())
        let month = NSCalendar.current.component(.month, from: Date())
        let day = NSCalendar.current.component(.day, from: Date())
        writtenDate = "\(year).\(month).\(day)"
    }

    @IBAction func registReview(_ sender: Any) {
        if let review = writeReview.text { reviewDictionary["review"] = review }
        reviewDictionary["rating"] = starRating.rating
        reviewDictionary["date"] = writtenDate
        reviewDictionary["userId"] = user["id"]
        reviewDictionary["cafeId"] = cafe["id"]
        
        reviewView.reviews.insert(reviewDictionary, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        reviewView.tableView.insertRows(at: [indexPath], with: .automatic)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelReview(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }

}
