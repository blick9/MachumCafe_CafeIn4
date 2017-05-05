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
        navigationItem.title = "맞춤카페"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        bannerArray = [#imageLiteral(resourceName: "mainBanner1"),#imageLiteral(resourceName: "mainBanner2"),#imageLiteral(resourceName: "mainBanner3")]
        
        for i in 0..<bannerArray.count {
            let bannerView = UIImageView()
            bannerView.contentMode = .scaleAspectFit
            bannerView.image = bannerArray[i]
            let xPosition = self.view.frame.width * CGFloat(i)
            bannerView.frame = CGRect(x: xPosition, y: 0, width: self.mainBannerScrollView.frame.width, height: self.mainBannerScrollView.frame.height)
            mainBannerScrollView.contentSize.width = mainBannerScrollView.frame.width * CGFloat(i + 1)
            mainBannerScrollView.addSubview(bannerView)
        }
        
        if let xib = Bundle.main.loadNibNamed("LocationLabelView", owner: self, options: nil)?.first as? LocationLabelView {
            self.view.addSubview(xib)
            xib.setLocationButton.addTarget(xib, action: #selector(xib.presentSetLocationView(target:)), for: .touchUpInside)
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
    
    @IBAction func findMyCafe(_ sender: Any) {
        let filterViewStoryboard = UIStoryboard(name: "FilterView", bundle: nil)
        let filterViewController = filterViewStoryboard.instantiateViewController(withIdentifier: "FilterView")
        present(filterViewController, animated: true, completion: nil)
    }
    
}
