//
//  FilterViewController.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 4. 28..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

protocol SavedFilterDelegate {
    func savedFilter (SavedFilter pickedFilter: [String?])
}

class FilterViewController: UIViewController {
    
    var delegate: SavedFilterDelegate?
    var multiple = true
    var filterArray = [String]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.allowsMultipleSelection = multiple
        self.navigationItem.title = "필터검색"
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "FilterCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "Cell")
        checkSelected()
    }
    
    func checkSelected() {
        for filter in filterArray {
            collectionView.selectItem(at: [0, categoryArray.index(of: filter)!], animated: false, scrollPosition: .top)
        }
    }
    
    @IBAction func resetFilterArray(_ sender: Any) {
        let selectedItem = collectionView.indexPathsForSelectedItems
        for item in selectedItem! {
            print(item)
            collectionView.deselectItem(at: item , animated: false)
        }
        filterArray.removeAll()
        print(filterArray)
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmFilter(_ sender: UIButton) {
        delegate?.savedFilter(SavedFilter: filterArray)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "applyFilter"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshMapMarkers"), object: nil)
        dismiss(animated: true, completion: nil)
    }
}

extension FilterViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FilterCollectionViewCell
        cell.category.text = categoryArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard multiple else { return }

        let filter = filterArray.filter { $0 == categoryArray[indexPath.row] }
        if filter.isEmpty {
            filterArray.append(categoryArray[indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let categoryIndex = categoryArray[indexPath.row]
   
        if let index = filterArray.index(of: categoryIndex) {
            filterArray.remove(at: index)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = categoryArray[indexPath.item].unicodeScalars.count * 15 + 25
        return CGSize(width: width, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}
