//
//  SuggestionImagePickerViewCollectionViewController.swift
//  MachumCafe
//
//  Created by Danb on 2017. 5. 11..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit
import Photos

private let reuseIdentifier = "Cell"

protocol SavedImageDelegate {
    func savedImage (SavedImage pickedImage: [UIImage?])
}

class SuggestionImagePickerViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var delegate : SavedImageDelegate?
    var imageArray = [UIImage]()
    var selectedImageArray = [UIImage]()
    var multiple = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "사진선택"
        grabPhotos()
        collectionView?.allowsMultipleSelection = multiple
        collectionView?.selectItem(at: nil, animated: true, scrollPosition: UICollectionViewScrollPosition())
        selectedImageArray.removeAll(keepingCapacity: false)
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    func grabPhotos() {
        let imageManager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .opportunistic
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        if let fetchResult : PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions) {
            if fetchResult.count > 0 {
                for i in 0..<fetchResult.count {
                    imageManager.requestImage(for: fetchResult.object(at: i) as! PHAsset, targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: requestOptions, resultHandler: {
                        (image, error) in
                        self.imageArray.append(image!)
                    })
                }
            }
            else {
                print("no photos")
                self.collectionView?.reloadData()
            }
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneActionButton(_ sender: Any) {
        delegate?.savedImage(SavedImage: selectedImageArray)
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let imageView = cell.viewWithTag(1) as! UIImageView
        imageView.image = imageArray[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        guard multiple else {
            return
        }
        cell.isSelected = !cell.isSelected
        selectedImageArray.append(imageArray[indexPath.row])
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let photoindex = imageArray[indexPath.row]
        if let index = selectedImageArray.index(of: photoindex) {
            selectedImageArray.remove(at: index)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 4 - 1
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
}
