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
    let tempArray = [[#imageLiteral(resourceName: "1"),#imageLiteral(resourceName: "2"),#imageLiteral(resourceName: "3"),#imageLiteral(resourceName: "4")],["압구정 사치커피", "스타벅스 역삼점", "카페 티", "클로이 뭐래츠"],["서울시 강남구 압구정동 471-47", "서울시 강남구 역삼동 714-28", "서울시 서초구 서초동 1024-5", "경기도 성남시 분당구 정자동 729번지"]]
    
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
        NetworkBookmark.getMyBookmark(userId: userId) { (message, cafe, bookmarkID) in
            print(message)
            Cafe.sharedInstance.bookmarkList = cafe
            print(Cafe.sharedInstance.bookmarkList)
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
        print(Cafe.sharedInstance.bookmarkList.count)
        return Cafe.sharedInstance.bookmarkList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! BookmarkViewCell
        
        cell.bookmarkCafeName.text = Cafe.sharedInstance.bookmarkList[indexPath.row].getCafe()["name"] as? String
        cell.bookmarkCafeAddress.text = Cafe.sharedInstance.bookmarkList[indexPath.row].getCafe()["address"] as? String
             return cell
    }
}
