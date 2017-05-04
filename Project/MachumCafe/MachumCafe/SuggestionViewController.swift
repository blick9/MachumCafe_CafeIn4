//
//  SuggestionViewController.swift
//  MachumCafe
//
//  Created by Danb on 2017. 5. 4..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class SuggestionViewController: UIViewController {

    
    let iconArray = [#imageLiteral(resourceName: "cafeIcon"),#imageLiteral(resourceName: "telephoneD"),#imageLiteral(resourceName: "adressD"),#imageLiteral(resourceName: "hourD")]
    let sugestionPlaceHolderArray = ["카페이름","전화번호","주소","영업시간"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension SuggestionViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sugestionPlaceHolderArray.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SuggestionTableViewCell
        cell.iconImage.image = iconArray[indexPath.row]
        cell.suggestionTextField.placeholder = sugestionPlaceHolderArray[indexPath.row]
        return cell
        if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SuggestionCategoryTableViewCell
            return cell
        }
    }
}
