//
//  SuggestionViewController.swift
//  MachumCafe
//
//  Created by Danb on 2017. 5. 4..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit
import GooglePlaces

class SuggestionViewController: UIViewController, SavedImageDelegate, UITextFieldDelegate {
    var multiple = true
    var filterArray = [String]()
    var cafeData = [String:Any]()
    var selectedLocation = CLLocationCoordinate2D()
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var suggestionScrollView: UIScrollView!

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
    var textFieldArray = [UITextField]()
    
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
        
        let nib = UINib(nibName: "FilterCollectionViewCell", bundle: nil)
        categoryCollectionView.register(nib, forCellWithReuseIdentifier: "Cell")
        if !cafeData.isEmpty {
            getCafeInfo()
            checkSelected()
        }
        
        self.textFieldArray = [nameTextField,telTextField,addressTextField,detailAddressTextField,hoursTextField]
        
        for textfield in textFieldArray{
            textfield.delegate = self
        }
        self.hideKeyboardWhenTappedAround()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func imagePickerActionButton(_ sender: Any) {
        let imagePickerViewController = UIStoryboard.SuggestionViewStoryboard.instantiateViewController(withIdentifier: "imagePicker") as! SuggestionImagePickerViewController
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
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        present(autocompleteController, animated: true, completion: nil)
    }
    
    @IBAction func doneActionButton(_ sender: Any) {
        let uploadImage = imageArray.flatMap { $0 }
        let address = "\(addressTextField.text!) " + "\(detailAddressTextField.text!)"
        
        if cafeData.isEmpty {
            NetworkAdmin.uploadsImage(images: uploadImage) { (imagesURL) in
                let cafe = ModelCafe(name: self.nameTextField.text!, tel: self.telTextField.text!, address: address, hours: self.hoursTextField.text!, latitude: self.selectedLocation.latitude, longitude: self.selectedLocation.longitude, category: self.filterArray, rating: 0.0, imagesURL: imagesURL)
                NetworkAdmin.suggestionNewCafe(cafe: cafe)
            }
        } else {
            NetworkAdmin.uploadsImage(images: uploadImage, callback: { (imagesURL) in
                self.cafeData["imagesData"] = [String]()
                self.cafeData["name"] = self.nameTextField.text!
                self.cafeData["tel"] = self.telTextField.text!
                self.cafeData["address"] = address
                self.cafeData["hours"] = self.hoursTextField.text!
                self.cafeData["category"] = self.filterArray
                let temp = self.cafeData["imagesURL"] as! [String]
                self.cafeData["imagesURL"] = temp + imagesURL
                NetworkAdmin.suggestionEditCafe(cafe: self.cafeData)
            })
        }
        UIAlertController().oneButtonAlert(target: self, title: "제보 완료", message: "소중한 의견 감사합니다.\n빠른시간 내에 적용하겠습니다 :)", isHandler: true)
    }
    
    func getCafeInfo() {
        nameTextField.text = cafeData["name"] as? String
        telTextField.text = cafeData["tel"] as? String
        addressTextField.text = cafeData["address"] as? String
        hoursTextField.text = cafeData["hours"] as? String
        filterArray = cafeData["category"] as! [String]
    }
    
    func checkSelected() {
        for filter in filterArray {
            categoryCollectionView.selectItem(at: [0, categoryArray.index(of: filter)!], animated: false, scrollPosition: .top)
        }
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FilterCollectionViewCell
        cell.category.text = categoryArray[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FilterCollectionViewCell
        guard multiple else {
            return
        }
        cell.isSelected = !cell.isSelected
        filterArray.append(categoryArray[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let categoryIndex = categoryArray[indexPath.row]
        if let index = filterArray.index(of: categoryIndex) {
            filterArray.remove(at: index)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Double((categoryArray[indexPath.row] as String).unicodeScalars.count) * 15.0 + 10
        return CGSize(width: width, height: 30.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3.0
    }
    
}

extension SuggestionViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        selectedLocation = place.coordinate
        NetworkMap.getAddressFromCoordinate(latitude: selectedLocation.latitude, longitude: selectedLocation.longitude) { address in
            self.addressTextField.text = address[0]
        }
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
//suggestionView 화면 클릭시 키보드 내리기
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        // canclesTouchesInView가 고정값으로 true임. true인 경우는 이전에 전달 된 터치를 touchesCancelled (_ : with :) 메시지를 통해 취소해야 다음 터치가 먹힌다. 하지만 false로 지정하면 멀티 터치가 되어 이 예외사항을 피할 수 있다.
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

