//
//  BookmarkViewController.swift
//  MachumCafe
//
//  Created by   minjae on 2017. 4. 28..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class BookmarkViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var userId = String()
    var userBookmark = [String]()

    override func viewWillAppear(_ animated: Bool) {
        // 네트워크에서 유저가 가진 북마크 목록 들고 오기
        getBookmarkList()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func getBookmarkList() {
        userId = User.sharedInstance.user.getUser()["id"] as! String
        userBookmark = User.sharedInstance.user.getUser()["bookmark"] as! [String]
        NetworkBookmark.getMyBookmark(userId: userId) { (message, cafe, bookmarkID) in
            print(message)
            Cafe.sharedInstance.bookmarkList = cafe
            self.collectionView.reloadData()
        }
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension BookmarkViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Cafe.sharedInstance.bookmarkList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! BookmarkViewCell
        
        cell.bookmarkCafeName.text = Cafe.sharedInstance.bookmarkList[indexPath.row].getCafe()["name"] as? String
        cell.bookmarkCafeAddress.text = Cafe.sharedInstance.bookmarkList[indexPath.row].getCafe()["address"] as? String
             return cell
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("You selected cell #\(indexPath.item)!")
//        prepare(for: , sender: <#T##Any?#>)
//    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailView" {
            if let item = self.collectionView.indexPathsForSelectedItems{
                let indexPath = item[0]
                    print(indexPath.row)
                _ = segue.destination as! CafeDetailViewController
                for cafe in Cafe.sharedInstance.cafeList {
                    if let cafeID = cafe.getCafe()["id"] {
                        if cafeID as! String == userBookmark[indexPath.row] {
                            
                        }
                    }
                }
                // cafeId를 이용해서 디테일뷰 그릴 수 있게 네트워크카페 api가 있음 좋겠다.
            }
        }
    }
    
}
