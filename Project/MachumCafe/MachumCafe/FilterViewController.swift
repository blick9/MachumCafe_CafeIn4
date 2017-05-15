//
//  FilterViewController.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 4. 28..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var categoryArray = ["24시","연중무휴","주차","편한의자","좌식","모임","미팅룸","스터디","넓은공간","아이와함께","디저트","베이커리","로스팅","산책로","모닥불","드라이브","북카페","이색카페","야경","조용한","고급스러운","여유로운","힐링"]
    var filterArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "필터검색"
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func pickFilter(_ button: UIButton) {
        button.isSelected = !button.isSelected

        if button.isSelected == true {
            for i in 0..<filterArray.count {
                if button.currentTitle == filterArray[i] {
                    filterArray.remove(at: i)
                }
            }
            filterArray.append(button.currentTitle!)
        }
        else {
            for i in 0..<filterArray.count {
                if button.currentTitle == filterArray[i] {
                    filterArray.remove(at: i)
                    break
                }
            }
        }
        print(filterArray)
    }

    @IBAction func resetFilterArray(_ sender: Any) {
        
        let selectedItem = collectionView.indexPathsForSelectedItems
        print(selectedItem)
        for item in selectedItem! {
            collectionView.deselectItem(at: item, animated: false)
        }
        //cell.category.isSelected == false
        //filterArray.removeAll()
            }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func confirmFilter(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension FilterViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FilterViewCell
        
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.init(red: 255, green: 232, blue: 129).cgColor
        cell.category.text = categoryArray[indexPath.row]
        cell.category.textColor = UIColor.init(red: 51, green: 51, blue: 51)
       // cell.category.setBackgroundImage(#imageLiteral(resourceName: "backgrondColor"), for: .selected)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FilterViewCell
        
       // print(indexPath.row)
        if cell.isSelected == true {
            cell.backgroundColor = UIColor.init(red: 255, green: 232, blue: 129)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FilterViewCell
        print(cell.isSelected)
    }
}

