//
//  ListViewController.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 4. 25..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    let tempArray = [[#imageLiteral(resourceName: "1"),#imageLiteral(resourceName: "2"),#imageLiteral(resourceName: "3"),#imageLiteral(resourceName: "4")],["압구정 사치커피", "스타벅스 역삼점", "카페 티", "클로이 뭐래츠"],["서울시 강남구 압구정동 471-47", "서울시 강남구 역삼동 714-28", "서울시 서초구 서초동 1024-5", "경기도 성남시 분당구 정자동 729번지"]]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        print(#function, "Table")
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cafe.sharedInstance.cafeList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListTableViewCell
        let cafeData = Cafe.sharedInstance.cafeList[indexPath.row].getCafe()
        
//        cell.backgroundImageView.image = (tempArray[0][indexPath.row] as! UIImage)
        cell.cafeNameLabel.text = cafeData["name"] as? String
        cell.cafeAddressLabel.text = cafeData["address"] as? String
        cell.distanceLabel.text = "1.2km"
        
        return cell
    }
    
}
