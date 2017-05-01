//
//  cafedetailViewController.swift
//  MachumCafe_Practice
//
//  Created by Danb on 2017. 4. 24..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class CafeDetailViewController: UIViewController {
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var reviewHeight: NSLayoutConstraint!
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var reviewTableView: UITableView!

    @IBOutlet var fullView: UIView!
 //  @IBOutlet weak var reviewMoreButton: UIButton!
    
    let cafeName = ["02-512-2395", "서울특별시 강남구 도산대로67길 13-12(청담동)","평일 AM 11:00 ~ AM 01:00","주차 가능","매장 내 위치","주차 가능","매장 내 위치"]
    let cafeIcon = [#imageLiteral(resourceName: "telephoneD"),#imageLiteral(resourceName: "adressD"),#imageLiteral(resourceName: "hourD"),#imageLiteral(resourceName: "parkD"),#imageLiteral(resourceName: "restroomD")]
    
    let reviewer = ["구제이", "한나", "메이플"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTableView.separatorInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        detailTableView.isScrollEnabled = false
        reviewTableView.isScrollEnabled = false
        let sceenCenter = fullView.center.x
        let reviewMoreButton = UIButton(frame: CGRect(x: Double(sceenCenter), y: Double(reviewHeight.constant+50), width: 185.0, height: 50.0))
        reviewMoreButton.layer.cornerRadius = 5
        reviewMoreButton.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
        reviewMoreButton.setTitle("\(reviewer.count)개의 리뷰 더 보기", for: .normal)
        reviewMoreButton.setTitleColor(UIColor.white, for: .normal)
       // reviewMoreButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        reviewMoreButton.titleLabel?.font = UIFont(name: "Apple SD 산돌고딕 Neo 일반체" , size: 14)
        self.view.addSubview(reviewMoreButton)
        
        // Do any additional setup after loading the view.
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        tableViewHeight.constant = CGFloat(Double(cafeIcon.count) * Double(detailTableView.rowHeight))
        reviewHeight.constant = CGFloat(3.0 * reviewTableView.rowHeight)
    
//        self.view.layoutIfNeeded()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CafeDetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.tag == 1 {
            return cafeIcon.count
        }
            
        else {
            return reviewer.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CafeDetailTableViewCell
            cell.detailLabel.text = cafeName[indexPath.row]
            cell.iconImage.image = cafeIcon[indexPath.row]
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CafeDetailReviewTableViewCell
            cell.reviewerNickName.text = reviewer[indexPath.row]
            return cell
        }
        
    }
}
