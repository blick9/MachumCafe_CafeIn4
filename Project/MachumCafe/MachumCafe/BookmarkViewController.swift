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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension BookmarkViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempArray[0].count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! BookmarkViewCell
        cell.bookmarkCafeImage.image = (tempArray[0][indexPath.row] as! UIImage)
        cell.bookmarkCafeName.text = (tempArray[1][indexPath.row] as! String)
        cell.bookmarkCafeAddress.text = (tempArray[2][indexPath.row] as! String)
        return cell
    }
}
