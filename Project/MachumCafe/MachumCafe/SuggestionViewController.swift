//
//  SuggestionViewController.swift
//  MachumCafe
//
//  Created by Danb on 2017. 5. 4..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit
import GooglePlaces

class SuggestionViewController: UIViewController, savedImageDelegate {
    var multiple = true
    var categoryArray = ["24시","연중무휴","주차","편한의자","좌식","모임","미팅룸","스터디","넓은공간","아이와함께","디저트","베이커리","로스팅","산책로","모닥불","드라이브","북카페","이색카페","야경","조용한","고급스러운","여유로운","힐링"]
    var filterArray = [String]()
    var selectedLocation = CLLocationCoordinate2D()
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var telTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var detailAddressTextField: UITextField!
    @IBOutlet weak var hoursTextField: UITextField!
    
    @IBOutlet weak var previewImage1: PreviewImageButton!
    @IBOutlet weak var previewImage2: PreviewImageButton!
    @IBOutlet weak var previewImage3: PreviewImageButton!
    @IBOutlet weak var previewImage4: PreviewImageButton!
    @IBOutlet weak var previewImage5: PreviewImageButton!
    
    var previewImage =  [PreviewImageButton]()
    var imageArray = [UIImage?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        previewImage = [previewImage1,previewImage2,previewImage3,previewImage4,previewImage5]
        for item in previewImage {
            item.addTarget(self, action: #selector(SuggestionViewController.buttonTapped), for: UIControlEvents.touchUpInside)
        }
        // addressTextField.sizeToFit()
        categoryCollectionView?.allowsMultipleSelection = multiple
        self.navigationItem.title = "필터검색"
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func imagePickerActionButton(_ sender: Any) {
        let imagePickerViewStoryboard = UIStoryboard(name: "SuggestionView", bundle: nil)
        let imagePickerViewController = imagePickerViewStoryboard.instantiateViewController(withIdentifier: "imagePicker") as! SuggestionImagePickerViewController
        let navigationVC = UINavigationController(rootViewController: imagePickerViewController)
        imagePickerViewController.delegate = self
        present(navigationVC, animated: false, completion: nil)
    }
    
    @IBAction func addressSerchButtonAction(_ sender: Any) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        let addressFilter = GMSAutocompleteFilter()
        addressFilter.type = .noFilter
        addressFilter.country = "KR"
        autocompleteController.autocompleteFilter = addressFilter
        
        present(autocompleteController, animated: true, completion: nil)
    }
    
    @IBAction func doneActionButton(_ sender: Any) {
        
        NetworkAdmin.uploadsImage(images: imageArray as! [UIImage]) { (imagesURL) in
            let cafe = ModelCafe(name: self.nameTextField.text!, tel: self.telTextField.text!, address: self.addressTextField.text!, hours: self.hoursTextField.text!, category: ["임시", "카테고리"], menu: "메뉴", imagesURL: imagesURL)
            NetworkAdmin.suggestionNewCafe(cafe: cafe)
        }
        self.dismiss(animated: true, completion: nil)

    }
    
    func draw() {
        imageArray = imageArray.filter { $0 != nil }.flatMap { return $0 }
        
        if imageArray.count < 5 {
            while imageArray.count < 5 {
                imageArray.append(nil)
            }
        }
        
        for i in 0..<imageArray.count {
            if imageArray[i] == nil {
                previewImage[i].setBackgroundImage(nil, for: .normal)
            } else {
                previewImage[i].setBackgroundImage(imageArray[i], for: .normal)
            }
        }
        print(imageArray, imageArray.count)
    }
    
    func savedImage(SavedImage pickedImage: [UIImage?]) {
        self.imageArray = pickedImage
        draw()
    }
    
    func buttonTapped(sender : PreviewImageButton) {
        for index in 0..<imageArray.count {
            if sender.tag == index {
                sender.isSelected = !sender.isSelected
                imageArray[index] = nil
            }
        }
        draw()
    }
    
    @IBAction func closedAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SuggestionViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FilterViewCell
        cell.sizeToFit()
        cell.layer.cornerRadius = cell.frame.height/2
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.init(red: 255, green: 232, blue: 129).cgColor
        cell.categoryName.text = categoryArray[indexPath.row]
        cell.categoryName.textColor = UIColor.init(red: 51, green: 51, blue: 51)
        cell.categoryName.sizeToFit()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FilterViewCell
        guard multiple else {
            return
        }
        cell.isSelected = !cell.isSelected
        filterArray.append(categoryArray[indexPath.row])
        print(filterArray)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FilterViewCell
        let categoryIndex = categoryArray[indexPath.row]
        if let index = filterArray.index(of: categoryIndex) {
            filterArray.remove(at: index)
        }
        print(filterArray)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 5 - 1
        return CGSize(width: width, height: 30.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
}

extension SuggestionViewController: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        
        addressTextField.text = place.formattedAddress
        selectedLocation = place.coordinate
        
        print(selectedLocation)
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}

