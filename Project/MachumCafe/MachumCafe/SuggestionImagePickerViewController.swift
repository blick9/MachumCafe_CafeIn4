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
    var selectedImageArray = [UIImage]()
    var imageDic = [Int : UIImage]()
    var multiple = true
    var photoLibrary: PhotoLibrary!
    var numberOfSection = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkAuthorized()
        navigationItem.title = "사진선택"
        collectionView?.allowsMultipleSelection = multiple
        collectionView?.selectItem(at: nil, animated: true, scrollPosition: UICollectionViewScrollPosition())
        selectedImageArray.removeAll(keepingCapacity: false)
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func checkAuthorized() {
        PHPhotoLibrary.requestAuthorization { result in
            if result == .authorized {
                self.photoLibrary = PhotoLibrary()
                self.numberOfSection = 1
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
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
        return numberOfSection
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoLibrary.getCount()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SuggestionImagePickerViewCollectionViewCell
        DispatchQueue.global(qos: .background).async {
            self.photoLibrary.setPhoto(at: indexPath.row) { (image) in
                if let image = image {
                    DispatchQueue.main.async {
                        self.imageDic[indexPath.row] = image
                        cell.photoLibraryImage.image = image
                    }
                }
            }
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard multiple else {
            return
        }
        
        if selectedImageArray.count != 5 {
            selectedImageArray.append(imageDic[indexPath.row]!)
        } else {
            collectionView.deselectItem(at: indexPath, animated: false)
            let alert = UIAlertController(title: "사진선택", message: "사진은 최대 5장까지 가능합니다.", preferredStyle: .alert)
            present(alert, animated: true, completion: nil)
            let time = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: time) {
                alert.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let photoindex = imageDic[indexPath.row]
        if let index = selectedImageArray.index(of: photoindex!) {
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
