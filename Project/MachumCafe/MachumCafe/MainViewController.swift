//
//  MainViewController.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 4. 25..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var mainBannerScrollView: UIScrollView!
    var bannerArray = [UIImage]()
    let listContainerViewController = UIStoryboard(name: "ListContainerView", bundle: nil).instantiateViewController(withIdentifier: "ListContainer")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "맞춤카페"
        bannerArray = [#imageLiteral(resourceName: "mainBanner1"),#imageLiteral(resourceName: "mainBanner2"),#imageLiteral(resourceName: "mainBanner3")]
       // mainBannerScrollView.frame = view.frame
        
        for i in 0..<bannerArray.count {
            let bannerView = UIImageView()
            bannerView.contentMode = .scaleAspectFit
            bannerView.image = bannerArray[i]
            let xPosition = self.view.frame.width * CGFloat(i)
            bannerView.frame = CGRect(x: xPosition, y: 0, width: self.mainBannerScrollView.frame.width, height: self.mainBannerScrollView.frame.height)
            
            mainBannerScrollView.contentSize.width = mainBannerScrollView.frame.width * CGFloat(i + 1)
            mainBannerScrollView.addSubview(bannerView)
        }
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
    
    
    @IBAction func categoryButtons(_ sender: UIButton) {
        navigationController?.pushViewController(listContainerViewController, animated: true)
    }
    
}
