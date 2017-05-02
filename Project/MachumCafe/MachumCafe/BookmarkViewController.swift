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
    
    let tempArray = [[#imageLiteral(resourceName: "1"),#imageLiteral(resourceName: "2"),#imageLiteral(resourceName: "3"),#imageLiteral(resourceName: "4")],["압구정 사치커피", "스타벅스 역삼점", "카페 티", "클로이 뭐래츠"],["서울시 강남구 압구정동 471-47", "서울시 강남구 역삼동 714-28", "서울시 서초구 서초동 1024-5", "경기도 성남시 분당구 정자동 729번지"]]
    
    override func viewWillAppear(_ animated: Bool) {
        // <임시 코드 -- 디테일 뷰 완성되면 지울 것!>네트워크 유저의 북마크에 카페 등록
//        NetworkBookmark.setMyBookmark(userId: User.sharedInstance.user.getUser()["id"] as! String, cafeId: Cafe.sharedInstance.cafeList[0].getCafe()["id"] as! String) { (message, string) in
//            print(message)
//            print(string)
//        }
//        NetworkBookmark.setMyBookmark(userId: User.sharedInstance.user.getUser()["id"] as! String, cafeId: Cafe.sharedInstance.cafeList[1].getCafe()["id"] as! String) { (message, string) in
//            print(message)
//            print(string)
//        }
        // 네트워크에서 유저가 가진 북마크 목록 들고 오기

        NetworkBookmark.getMyBookmark(userId: User.sharedInstance.user.getUser()["id"] as! String) { (message, cafe) in
            Cafe.sharedInstance.bookmarkList = cafe
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
       
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
       // cell.bookmarkCafeName.text = userBookmark[indexPath.row]["name"] as! String
//        cell.bookmarkCafeImage.image = (tempArray[0][indexPath.row] as! UIImage)
//        cell.bookmarkCafeName.text = (tempArray[1][indexPath.row] as! String)
//        cell.bookmarkCafeAddress.text = (tempArray[2][indexPath.row] as! String)
        return cell
    }
}
