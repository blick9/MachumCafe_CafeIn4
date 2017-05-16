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
    @IBOutlet weak var telTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var hoursTextField: UITextField!
    
    @IBOutlet weak var pickedImage1: UIImageView?
    @IBOutlet weak var pickedImage2: UIImageView?
    @IBOutlet weak var pickedImage3: UIImageView?
    
    var imageArray = [UIImage]()
    
    @IBAction func imagePickerActionButton(_ sender: Any) {
        let imagePickerViewStoryboard = UIStoryboard(name: "SuggestionView", bundle: nil)
        let imagePickerViewController = imagePickerViewStoryboard.instantiateViewController(withIdentifier: "imagePicker") as! SuggestionImagePickerViewController
        let navigationVC = UINavigationController(rootViewController: imagePickerViewController)
        imagePickerViewController.delegate = self
        present(navigationVC, animated: false, completion: nil)
    }
    
    @IBAction func doneActionButton(_ sender: Any) {
        
        NetworkAdmin.uploadsImage(images: imageArray) { (imagesURL) in
            let cafe = ModelCafe(name: self.nameTextField.text!, tel: self.telTextField.text!, address: self.addressTextField.text!, hours: self.hoursTextField.text!, category: ["임시", "카테고리"], menu: "메뉴", imagesURL: imagesURL)
            NetworkAdmin.suggestionNewCafe(cafe: cafe)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func savedImage(SaveedImage pickedImage: [UIImage]) {
        pickedImage1?.image = pickedImage[0]
        pickedImage2?.image = pickedImage[1]
        pickedImage3?.image = pickedImage[2]
        
        self.imageArray = pickedImage
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
