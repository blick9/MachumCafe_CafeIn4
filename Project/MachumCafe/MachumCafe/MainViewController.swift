//
//  MainViewController.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 4. 25..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var bannerArray = [UIImage]()
    
    @IBOutlet weak var mainBannerScrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "맞춤카페"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        makeBannerScrollView()
        if let locationLabelxib = Bundle.main.loadNibNamed("LocationLabelView", owner: self, options: nil)?.first as? LocationLabelView {
            locationLabelxib.delegate = self
            self.view.addSubview(locationLabelxib)
        }
    }
    
    func makeBannerScrollView() {
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
    }
    
    @IBAction func sideBarShowButtonAction(_ sender: Any) {
        let sideBarViewController = UIStoryboard.MainViewStoryboard.instantiateViewController(withIdentifier: "SideBar")
        present(sideBarViewController, animated: false, completion: nil)
    }
    
    @IBAction func categoryButtons(_ sender: UIButton) {
        let listContainerViewController = UIStoryboard.ListContainerViewStoryboard.instantiateViewController(withIdentifier: "ListContainer")
        navigationController?.pushViewController(listContainerViewController, animated: true)
    }
    
    @IBAction func presentFilterViewButtonAction(_ sender: Any) {
        let filterViewController = UIStoryboard.FilterViewStoryboard.instantiateViewController(withIdentifier: "FilterView")
        present(filterViewController, animated: true, completion: nil)
    }
    
}
