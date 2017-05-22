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
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var isEmptyLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "즐겨찾기"
        collectionView.delegate = self
        collectionView.dataSource = self
        reloadBookmarkData()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadBookmarkData), name: NSNotification.Name(rawValue: "reloadBookmark"), object: nil)
    }
    
    func getBookmarkList() {
        let activityIndicator = UIActivityIndicatorView()
        let startedIndicator = activityIndicator.showActivityIndicatory(view: self.view)
        NetworkBookmark.getMyBookmark(userId: userId) { (message, cafeList) in
            Cafe.sharedInstance.bookmarkList = cafeList
            self.collectionView.reloadData()
            activityIndicator.stopActivityIndicator(view: self.view, currentIndicator: startedIndicator)
        }
    }
    
    func reloadBookmarkData() {
        getBookmarkList()
        isEmptyLabel.text = (User.sharedInstance.user.getUser()["bookmark"] as! [String]).isEmpty ? "즐겨찾는 카페가 없습니다." : ""
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
        var modelBookmark = Cafe.sharedInstance.bookmarkList[indexPath.row].getCafe()

        if (modelBookmark["imagesData"] as! [Data]).isEmpty {
            NetworkCafe.getImagesData(imagesURL: modelBookmark["imagesURL"] as! [String]) { (data) in
                Cafe.sharedInstance.bookmarkList[indexPath.row].setImagesData(imageData: data)
                modelBookmark = Cafe.sharedInstance.bookmarkList[indexPath.row].getCafe()
                cell.bookmarkCafeImage.image = UIImage(data: (modelBookmark["imagesData"] as! [Data])[0])
            }
        } else {
            cell.bookmarkCafeImage.image = UIImage(data: (modelBookmark["imagesData"] as! [Data])[0])
        }
        
        cell.bookmarkCafeName.text = modelBookmark["name"] as? String
        cell.bookmarkCafeAddress.text = modelBookmark["address"] as? String
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
