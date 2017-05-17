//
//  ReviewViewController.swift
//  MachumCafe
//
//  Created by   minjae on 2017. 5. 15..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    var reviews = [[String: Any]]()
    var reviewArray = [[String: Any]]()
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let writeReview : WriteReviewViewController = (segue.destination as? WriteReviewViewController)!
        writeReview.reviewView = self
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
        
        let item = reviews[indexPath.row]
        cell.reviewContent.text = item["review"] as! String
        cell.reviewStarRating.rating = item["rating"] as! Double
        cell.reviewDate.text = item["date"] as! String
        cell.reviewer.text = item["userId"] as! String
        
        return cell
    }
}

