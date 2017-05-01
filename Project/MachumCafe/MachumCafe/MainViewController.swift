//
//  MainViewController.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 4. 25..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "맞춤카페"

        firstInit()
    }
    
    func firstInit() {
        let cafeData = ModelCafe(id: "idtest1234", name: "커피스미스", phoneNumber: "02-1234-5678", address: "서울시 강남구 역삼동 999", hours: "11:00~12:00", latitude: "00000.00000", longitude: "1111.11111", category: ["24시", "흡연실", "주차가능"], summary: nil, mainMenu: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sideBarShowButtonAction(_ sender: Any) {
        let mainViewStoryboard = UIStoryboard(name: "MainView", bundle: nil)
        let sideBarViewController = mainViewStoryboard.instantiateViewController(withIdentifier: "SideBar")
        
        present(sideBarViewController, animated: false, completion: nil)
    }

    @IBAction func tempShowListButtonAction(_ sender: Any) {
        let listContainerViewStoryboard = UIStoryboard(name: "ListContainerView", bundle: nil)
        let listContainerViewController = listContainerViewStoryboard.instantiateViewController(withIdentifier: "ListContainer")
        
        navigationController?.pushViewController(listContainerViewController, animated: true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
