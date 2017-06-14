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
        NetworkBookmark.getMyBookmark(userId: userId) { (cafeList) in
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailView" {
            if let indexPaths = self.collectionView.indexPathsForSelectedItems{
                let controller = segue.destination as! CafeDetailViewController
                controller.currentCafeModel = Cafe.sharedInstance.bookmarkList[indexPaths[0].row]
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        clearMemory()
    }
}

extension BookmarkViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Cafe.sharedInstance.bookmarkList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! BookmarkViewCell
        var modelBookmark = Cafe.sharedInstance.bookmarkList[indexPath.row].getCafe()
        
        if !(modelBookmark["imagesURL"] as! [String]).isEmpty {
            let cafeImage = NetworkCafe.getCafeImage(imageURL: (modelBookmark["imagesURL"] as! [String])[0])
            cell.bookmarkCafeImage.kf.setImage(with: cafeImage)
        } else {
            cell.bookmarkCafeImage.image = #imageLiteral(resourceName: "2")
        }
        
        cell.bookmarkCafeName.text = modelBookmark["name"] as? String
        cell.bookmarkCafeAddress.text = modelBookmark["address"] as? String
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2 - 6
        return CGSize(width: width, height: width*1.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 7, left: 4, bottom: 5, right: 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
}
