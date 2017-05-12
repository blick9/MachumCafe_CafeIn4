//
//  SuggestionViewController.swift
//  MachumCafe
//
//  Created by Danb on 2017. 5. 4..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class SuggestionViewController: UIViewController, savedImageDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var adderessTextField: UITextField!
    @IBOutlet weak var hourTextField: UITextField!
    
    @IBOutlet weak var pickedImage1: UIImageView!
    @IBOutlet weak var pickedImage2: UIImageView!
    @IBOutlet weak var pickedImage3: UIImageView!
    
    var imageArray = [UIImage]()
    
    @IBAction func imagePickerActionButton(_ sender: Any) {
        let imagePickerViewStoryboard = UIStoryboard(name: "SuggestionView", bundle: nil)
        let imagePickerViewController = imagePickerViewStoryboard.instantiateViewController(withIdentifier: "imagePicker") as! SuggestionImagePickerViewCollectionViewController
        let navigationVC = UINavigationController(rootViewController: imagePickerViewController)
        imagePickerViewController.delegate = self
        present(navigationVC, animated: false, completion: nil)
    }
    
    @IBAction func doneActionButton(_ sender: Any) {
        print(nameTextField.text)
        print(phoneNumberTextField.text)
        print(adderessTextField.text)
        print(hourTextField.text)
        print(imageArray)
       // test = imagePickerController.selectedImageArray
       // print("test:", test)
        

    }
    
    func savedImage(SaveedImage pickedImage: [UIImage]) {
        self.imageArray = pickedImage
        print(pickedImage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
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
