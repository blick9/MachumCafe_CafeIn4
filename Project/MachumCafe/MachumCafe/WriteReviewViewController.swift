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
    
    var reviewDictionary = [String : Any]()
    var reviewView = ReviewViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewDictionary["review"] = writeReview.text
        reviewDictionary["starRating"] = starRating.rating
        

        // Do any additional setup after loading the view.
    }

    @IBAction func registReview(_ sender: Any) {
        print(starRating.rating)
        
        if let review = writeReview.text { reviewDictionary["review"] = review }
        reviewDictionary["starRating"] = starRating.rating
        reviewView.reviews.insert(reviewDictionary, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        reviewView.tableView.insertRows(at: [indexPath], with: .automatic)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelReview(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }

}
