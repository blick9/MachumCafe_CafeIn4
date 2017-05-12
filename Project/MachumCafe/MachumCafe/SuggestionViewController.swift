//
//  SuggestionViewController.swift
//  MachumCafe
//
//  Created by Danb on 2017. 5. 4..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class SuggestionViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var adderessTextField: UITextField!
    @IBOutlet weak var hourTextField: UITextField!
    
    @IBOutlet weak var pickedImage1: UIImageView!
    
    @IBOutlet weak var pickedImage2: UIImageView!
    
    @IBOutlet weak var pickedImage3: UIImageView!
    
    var test = [UIImage]()
    let iconArray = [#imageLiteral(resourceName: "cafeIcon"),#imageLiteral(resourceName: "telephoneD"),#imageLiteral(resourceName: "adressD"),#imageLiteral(resourceName: "hourD")]
    let suggestionPlaceHolderArray = ["카페이름","전화번호","주소","영업시간"]
    var writeTextFieldArray = [String]()
    
    @IBAction func imagePickerActionButton(_ sender: Any) {
        let imagePickerViewStoryboard = UIStoryboard(name: "SuggestionView", bundle: nil)
        let imagePickerViewController = imagePickerViewStoryboard.instantiateViewController(withIdentifier: "imagePicker")
        let navigationVC = UINavigationController(rootViewController: imagePickerViewController)
        
        present(navigationVC, animated: false, completion: nil)
    }
    
    @IBAction func doneActionButton(_ sender: Any) {
        let imagePickerStoryboard = UIStoryboard(name: "SuggestionView", bundle: nil)
        let imagePickerController = imagePickerStoryboard.instantiateViewController(withIdentifier: "imagePicker") as! SuggestionImagePickerViewCollectionViewController
        print(nameTextField.text)
        print(phoneNumberTextField.text)
        print(adderessTextField.text)
        print(hourTextField.text)
        test = imagePickerController.selectedImageArray
        print("test:", test)
        

    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //pickedImage1.image = selecte

//        suggestiontableView.separatorColor = UIColor.lightGray
//        suggestiontableView.separatorStyle = .singleLine
//        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func closedAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}



/*
extension SuggestionViewController : UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func doneActionButton(_ sender: Any) {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SuggestionTableViewCell
//        let suggestionCell = cell.suggestionTextField.text
//        writeTextFieldArray.append(suggestionCell!)

        print(writeTextFieldArray)
       // self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 4 {
            return 100
        }
        else {
            return 50
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return iconArray.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SuggestionCategoryTableViewCell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SuggestionTableViewCell
        cell.iconImage.image = iconArray[indexPath.row]
        cell.suggestionTextField.placeholder = suggestionPlaceHolderArray[indexPath.row]
        writeTextFieldArray.append(cell.suggestionTextField.text!)
        return cell
    }
}
 */
