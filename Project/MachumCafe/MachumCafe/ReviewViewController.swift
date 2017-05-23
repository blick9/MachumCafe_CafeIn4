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
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        reviews = currentCafeModel.getReviews()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadReviewTable), name: NSNotification.Name(rawValue: "refreshReview"), object: nil)
    }
    
    func reloadReviewTable() {
        reviews = currentCafeModel.getReviews()
        tableView.reloadData()
        print("Change!reload!")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let writeReviewView : WriteReviewViewController = (segue.destination as? WriteReviewViewController)!
        writeReviewView.reviewView = self
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
        
        let item = reviews[indexPath.row].getReview()
        cell.reviewer.text = item["nickname"] as? String
        cell.reviewDate.text = item["date"] as? String
        cell.reviewContent.text = item["reviewContent"] as? String
        cell.reviewStarRating.rating = item["rating"] as! Double

        return cell
    }
}

