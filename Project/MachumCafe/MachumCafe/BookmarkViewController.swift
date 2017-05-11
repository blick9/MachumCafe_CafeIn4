//
//  BookmarkViewController.swift
//  MachumCafe
//
//  Created by   minjae on 2017. 4. 28..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class BookmarkViewController: UIViewController {
    var userId = User.sharedInstance.user.getUser()["id"] as! String
    var userBookmark = [String]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var isEmptyLabel: UILabel!

    override func viewWillAppear(_ animated: Bool) {
        userBookmark = User.sharedInstance.user.getUser()["bookmark"] as! [String]
        isEmptyLabel.text = userBookmark.isEmpty ? "즐겨찾는 카페가 없습니다." : ""
        self.collectionView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "즐겨찾기"
        collectionView.delegate = self
        collectionView.dataSource = self

        getBookmarkList()
    }
    
    func getBookmarkList() {
        let activityIndicator = UIActivityIndicatorView()
        let startedIndicator = activityIndicator.showActivityIndicatory(view: self.view)
        NetworkBookmark.getMyBookmark(userId: userId) { (message, cafeList, bookmarkID) in
            Cafe.sharedInstance.bookmarkList = cafeList
            for cafe in cafeList {
                NetworkCafe.getImagesData(imagesURL: cafe.getCafe()["imagesURL"] as! [String], callback: { (imageData) in
                    cafe.setImagesData(imageData: imageData)
                    self.collectionView.reloadData()
                })
            }
            activityIndicator.stopActivityIndicator(view: self.view, currentIndicator: startedIndicator)
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
        let bookmarkCafeData = Cafe.sharedInstance.bookmarkList[indexPath.row].getCafe()
        let imagesData = bookmarkCafeData["imagesData"] as! [Data]
        if !imagesData.isEmpty {
            cell.bookmarkCafeImage.image = UIImage(data: imagesData[0])
        }
        cell.bookmarkCafeName.text = bookmarkCafeData["name"] as? String
        cell.bookmarkCafeAddress.text = bookmarkCafeData["address"] as? String
             return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailView" {
            if let indexPaths = self.collectionView.indexPathsForSelectedItems{
                let controller = segue.destination as! CafeDetailViewController
                controller.cafeModel = Cafe.sharedInstance.bookmarkList[indexPaths[0].row]
            }
        }
    }
    
}
