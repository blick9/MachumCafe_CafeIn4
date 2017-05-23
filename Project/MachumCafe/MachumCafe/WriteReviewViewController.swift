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
    var currentCafeModel = ModelCafe()
    var cafeData = [String:Any]()
    var reviewView = ReviewViewController()
    var userData = User.sharedInstance.user.getUser()
    var writtenDate = Date()

    @IBOutlet weak var writeReview: UITextView!
    @IBOutlet weak var starRating: CosmosView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cafeData = currentCafeModel.getCafe()
        starRating.rating = 0
        print(currentCafeModel.getReviews())
    }

    @IBAction func registReview(_ sender: Any) {
        //TODO: 작성일 추가
        let review = ModelReview(cafeId: cafeData["id"] as! String, userId: userData["id"] as! String, nickname: userData["nickname"] as! String, date: "dateTest", reviewContent: writeReview.text, rating: starRating.rating)
        NetworkCafe.postCafeReview(review: review) { (bool, modelReviews) in
            self.currentCafeModel.setReviews(reviews: modelReviews)
        }


//        let indexPath = IndexPath(row: 0, section: 0)
//        reviewView.tableView.insertRows(at: [indexPath], with: .automatic)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelReview(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
