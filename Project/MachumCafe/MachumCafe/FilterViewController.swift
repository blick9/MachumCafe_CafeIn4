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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var multiple = true
    var categoryArray = ["24시", "연중무휴", "주차", "편한의자", "좌식", "모임", "미팅룸", "스터디", "넓은공간", "아이와함께", "디저트", "베이커리", "로스팅", "산책로", "모닥불", "드라이브", "북카페", "이색카페", "야경", "조용한", "고급스러운", "여유로운", "힐링"]
    var filterArray = [String]()
    
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
        dismiss(animated: true, completion: nil)
    }
}

extension FilterViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FilterCollectionViewCell
        cell.category.text = categoryArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard multiple else {
            return
        }

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
        let width = Double((categoryArray[indexPath.row] as String).unicodeScalars.count) * 15.0 + 20
        return CGSize(width: width, height: 35.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
}

