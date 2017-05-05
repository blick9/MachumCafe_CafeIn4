//
//  SuggestionViewController.swift
//  MachumCafe
//
//  Created by Danb on 2017. 5. 4..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class SuggestionViewController: UIViewController {

    @IBOutlet weak var suggestiontableView: UITableView!
    
    let iconArray = [#imageLiteral(resourceName: "cafeIcon"),#imageLiteral(resourceName: "telephoneD"),#imageLiteral(resourceName: "adressD"),#imageLiteral(resourceName: "hourD"),#imageLiteral(resourceName: "imageD")]
    let suggestionPlaceHolderArray = ["카페이름","전화번호","주소","영업시간","사진사진사지이이이인"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        suggestiontableView.separatorInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "cancelButton")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
extension SuggestionViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 5 {
            return 75
        }
        else{
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return iconArray.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SuggestionCategoryTableViewCell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SuggestionTableViewCell
        cell.iconImage.image = iconArray[indexPath.row]
        cell.suggestionTextField.placeholder = suggestionPlaceHolderArray[indexPath.row]
        return cell
        }
    }
