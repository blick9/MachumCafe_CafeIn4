//
//  MainViewController.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 4. 25..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIScrollViewDelegate {
    
    var bannerArray = [UIImage]()
    var filterArray = [String]()
    
    //@IBOutlet weak var mainBannerScrollView: UIScrollView!
//    @IBOutlet weak var mainBannerPageController: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "맞춤카페"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        //makeBannerScrollView()
        //mainBannerScrollView.delegate = self
        
        if let locationLabelxib = Bundle.main.loadNibNamed("LocationLabelView", owner: self, options: nil)?.first as? LocationLabelView {
            locationLabelxib.delegate = self
            locationLabelxib.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: locationLabelxib.frame.height)
            self.view.addSubview(locationLabelxib)
        }
        //Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(autoScrollMainBanner), userInfo: nil, repeats: true)
    }
    /*
    func makeBannerScrollView() {
        bannerArray = [#imageLiteral(resourceName: "mainBanner1"),#imageLiteral(resourceName: "mainBanner2"),#imageLiteral(resourceName: "mainBanner3")]
        mainBannerScrollView.isPagingEnabled = true
        mainBannerPageController.numberOfPages = bannerArray.count
        mainBannerPageController.currentPage = 0
        
        for i in 0..<bannerArray.count {
            let bannerView = UIImageView()
            let connectLinkButton = UIButton()
            let xPosition = self.view.frame.width * CGFloat(i)
            bannerView.contentMode = .scaleToFill
            bannerView.image = bannerArray[i]
            bannerView.frame = CGRect(x: xPosition, y: 0, width: self.view.frame.width, height: self.mainBannerScrollView.frame.height)
            connectLinkButton.frame = CGRect(x: xPosition, y: 0, width: self.view.frame.width, height: self.mainBannerScrollView.frame.height)
            connectLinkButton.tag = i
            connectLinkButton.addTarget(self, action: #selector(touchedMainBanner(_:)), for: .touchUpInside)
            mainBannerScrollView.addSubview(bannerView)
            mainBannerScrollView.addSubview(connectLinkButton)
        }
        mainBannerScrollView.contentSize.width = view.frame.width * CGFloat(bannerArray.count)
    }
    
    func autoScrollMainBanner() {
        let pageIndex = Int(round(mainBannerScrollView.contentOffset.x / view.frame.width))
        var contentOffset = CGPoint()
        contentOffset = pageIndex == bannerArray.count - 1 ? CGPoint(x: 0, y: 0) : CGPoint(x: (mainBannerScrollView.contentOffset.x + view.frame.width), y: 0)
        mainBannerScrollView.setContentOffset(contentOffset, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        mainBannerPageController.currentPage = Int(pageIndex)
    }
    
    
    func touchedMainBanner(_ sender: UIButton) {
        let listContainerViewController = UIStoryboard.ListContainerViewStoryboard.instantiateViewController(withIdentifier: "ListContainer") as! ListContainerViewController
        navigationController?.pushViewController(listContainerViewController, animated: true)
        
        var element : String?
        switch sender.tag {
        case 0:
            element = "조용한"
        case 1:
            element = "힐링"
        case 2:
            element = "로스팅"
        default:
            break
        }
        
        if let value = element {
            listContainerViewController.selectedFilterArray.append(value)
        }
    }
    */
    @IBAction func sideBarShowButtonAction(_ sender: Any) {
        let sideBarViewController = UIStoryboard.MainViewStoryboard.instantiateViewController(withIdentifier: "SideBar")
        present(sideBarViewController, animated: false, completion: nil)
    }
    
    @IBAction func categoryButtons(_ sender: UIButton) {
        let listContainerViewController = UIStoryboard.ListContainerViewStoryboard.instantiateViewController(withIdentifier: "ListContainer") as! ListContainerViewController
        navigationController?.pushViewController(listContainerViewController, animated: true)
        
        var element : String?
        switch sender.tag {
        case 0:
            element = nil
        case 1:
            element = "24시"
        case 2:
            element = "주차"
        case 3:
            element = "디저트"
        case 4:
            element = "로스팅"
        case 5:
            element = "미팅룸"
        default:
            break
        }
        
        if let value = element {
            listContainerViewController.selectedFilterArray.append(value)
        }
    }
    
    @IBAction func presentFilterViewButtonAction(_ sender: Any) {
        let listContainerViewController = UIStoryboard.ListContainerViewStoryboard.instantiateViewController(withIdentifier: "ListContainer") as! ListContainerViewController
        navigationController?.pushViewController(listContainerViewController, animated: false)
        listContainerViewController.showFilterView()
    }
    
}
