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
    var userData = User.sharedInstance.user.getUser()
    var writtenDate = Date()
    var reviewDictionary = Review.sharedInstance.review.getReview()
    var user = User.sharedInstance.user.getUser()
    var cafe = Cafe.sharedInstance.allCafeList[1].getCafe()
    
    @IBOutlet weak var writeReview: UITextView!
    @IBOutlet weak var starRating: CosmosView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cafeData = currentCafeModel.getCafe()
        starRating.rating = 0
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        writeReview.resignFirstResponder()
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if self.view.frame.origin.y == 0{
            self.view.frame.origin.y -= 100
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y += 100
        }
    }
    @IBAction func registReview(_ sender: Any) {
        if writeReview.text.isEmpty || starRating.rating == 0 {
            UIAlertController().oneButtonAlert(target: self, title: "리뷰 등록", message: "별점 또는 내용을 입력해주세요.", isHandler: false)
        } else {
            if User.sharedInstance.isUser {
                let review = ModelReview(isKakaoImage: userData["isKakaoImage"] as! Bool, cafeId: cafeData["id"] as! String, userId: userData["id"] as! String, nickname: userData["nickname"] as! String, profileImageURL: userData["profileImageURL"] as? String, date: "dateTest", reviewContent: writeReview.text, rating: starRating.rating)
                NetworkCafe.postCafeReview(review: review, callback: { (modelReviews, rating) in
                    self.currentCafeModel.setReviews(reviews: modelReviews)
                    self.currentCafeModel.setRating(rating: rating)
                    self.dismiss(animated: false, completion: nil)
                })
            } else {
                UIAlertController().oneButtonAlert(target: self, title: "리뷰 등록실패", message: "로그인 후 이용해주세요.", isHandler: false)
            }
        }
    }
    
    @IBAction func cancelReview(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}
