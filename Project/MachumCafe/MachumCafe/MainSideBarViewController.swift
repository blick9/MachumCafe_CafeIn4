//
//  MainSideBarViewController.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 4. 25..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class MainSideBarViewController: UIViewController {
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var sideBarView: UIView!
    @IBOutlet weak var sideBarLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userInfoLabel: UILabel!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var myBookmarkButton: UIButton!
    @IBOutlet weak var reportButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var settingProfileImage: UIButton!
    @IBOutlet weak var settingProfileImageIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideBarLeadingConstraint.constant = -(self.sideBarView.frame.width+10)
        sideBarView.layer.shadowOpacity = 0.5
        sideBarView.layer.shadowColor = UIColor.black.cgColor
        sideBarView.layer.shadowRadius = 3
        userProfileImageView.layer.masksToBounds = true
        userProfileImageView.layer.cornerRadius = CGFloat(userProfileImageView.frame.height / 2)
        
        imagePicker.delegate = self
        
        buttonInit()
        checkIsUser()
        NotificationCenter.default.addObserver(self, selector: #selector(checkIsUser), name: NSNotification.Name(rawValue: "checkIsUser"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.keyWindow?.windowLevel = (UIWindowLevelStatusBar + 1)
    }
    
    func checkIsUser() {
        switch User.sharedInstance.isUser {
        case false :
            userProfileImageView.image = #imageLiteral(resourceName: "profil_side")
            userInfoLabel.isHidden = true
            logInButton.isHidden = false
            settingProfileImage.isEnabled = false
            settingProfileImageIcon.isHidden = true
        case true :
            let user = User.sharedInstance.user.getUser()
            if !(user["profileImageURL"] as! String).isEmpty {
                let profileImage = NetworkUser.getUserImage(userID: user["id"] as! String, isKakaoImage: user["isKakaoImage"] as! Bool, imageURL: user["profileImageURL"] as! String)
                userProfileImageView.kf.setImage(with: profileImage)
            } else {
                userProfileImageView.image = #imageLiteral(resourceName: "profil_side")
            }
            userInfoLabel.isHidden = false
            userInfoLabel.text = ("\(User.sharedInstance.user.getUser()["nickname"] as! String)님")
            logInButton.isHidden = true
            settingProfileImage.isEnabled = true
            settingProfileImageIcon.isHidden = false
        }
    }
    
    func buttonInit() {
        logInButton.layer.borderWidth = 1
        logInButton.layer.borderColor = UIColor.gray.cgColor
        logInButton.layer.cornerRadius = self.logInButton.frame.height/CGFloat(2)
        logInButton.tintColor = UIColor.lightGray
        logInButton.contentEdgeInsets = UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10)
        
        reportButton.tintColor = UIColor.black
        myBookmarkButton.tintColor = UIColor.black
        
        let attrs = [NSFontAttributeName : UIFont.systemFont(ofSize: 15),
                     NSForegroundColorAttributeName : UIColor.gray,
                     NSUnderlineStyleAttributeName : 1] as [String : Any]
        
        let buttonTitleString = NSMutableAttributedString(string: "설정", attributes:attrs)
        settingButton.setAttributedTitle(buttonTitleString, for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.sideBarLeadingConstraint.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            self.view.layoutIfNeeded()
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIApplication.shared.keyWindow?.windowLevel = (UIWindowLevelStatusBar - 1)
    }
    
    func setProfileImage() {
        let actionController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "직접 촬영", style: .default) { _ in
            print("사진")
            self.presentImagePickerType(sourceType: .camera)
        }
        let photoAlbumAction = UIAlertAction(title: "사진 앨범에서 선택", style: .default) { _ in
            print("앨범")
            self.presentImagePickerType(sourceType: .photoLibrary)
        }
        let closeAction = UIAlertAction(title: "닫기", style: .cancel)
        actionController.addAction(cameraAction)
        actionController.addAction(photoAlbumAction)
        actionController.addAction(closeAction)
        present(actionController, animated: true, completion: nil)
    }
    
    func presentImagePickerType(sourceType: UIImagePickerControllerSourceType) {
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func setProfileImageButtonAction(_ sender: Any) {
        setProfileImage()
    }
    
    @IBAction func logInButtonAction(_ sender: Any) {
        let logInViewController = UIStoryboard.LogInSignUpViewStoryboard.instantiateViewController(withIdentifier: "LogIn")
        present(logInViewController, animated: true, completion: nil)
    }
    
    @IBAction func bookmarkButtonAction(_ sender: Any) {
        if !User.sharedInstance.isUser {
            UIAlertController().presentSuggestionLogInAlert(target: self, title: "즐겨찾기", message: "로그인 후 이용해주세요.")
        } else {
            let bookmarkViewController = UIStoryboard.BookmarkViewStoryboard.instantiateViewController(withIdentifier: "Bookmark")
            let bookmarkViewNavigationController = UINavigationController(rootViewController: bookmarkViewController)
            present(bookmarkViewNavigationController, animated: true, completion: nil)
        }
    }
    
    @IBAction func suggestionButtonAction(_ sender: Any) {
        let suggestionViewController = UIStoryboard.SuggestionViewStoryboard.instantiateViewController(withIdentifier: "Suggestion")
        let suggestionViewNavigationController = UINavigationController(rootViewController: suggestionViewController)
        present(suggestionViewNavigationController, animated: true, completion: nil)
    }
    

    @IBAction func settingButtonAction(_ sender: Any) {
        let settingViewController = UIStoryboard.SettingViewStoryboard.instantiateViewController(withIdentifier: "SettingView")
        let settingViewNavtigationController = UINavigationController(rootViewController: settingViewController)
        present(settingViewNavtigationController, animated: true, completion: nil)
    }
    
    @IBAction func closeViewButtonAction(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.sideBarLeadingConstraint.constant = -(self.sideBarView.frame.width+10)
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0)
            self.view.layoutIfNeeded()
        }) { (bool) in
            self.dismiss(animated: false, completion: nil)
        }
    }
}

extension MainSideBarViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] {
            dismiss(animated: true, completion: nil)
            NetworkUser.setUserProfileImage(userID: User.sharedInstance.user.getUser()["id"] as! String, image: image as! UIImage, callback: { (result) in
                if result {
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "checkIsUser"), object: nil)
                    }
                } else {
                    UIAlertController().oneButtonAlert(target: self, title: "에러", message: "잠시 후 다시 시도해주세요.", isHandler: false)
                }
            })
        }
    }
}
