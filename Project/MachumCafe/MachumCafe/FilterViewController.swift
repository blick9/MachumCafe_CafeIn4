//
//  FilterViewController.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 4. 28..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    @IBOutlet weak var allnight: UIButton!
    @IBOutlet weak var dessert: UIButton!
    @IBOutlet weak var smoking: UIButton!
    @IBOutlet weak var parkinglot: UIButton!
    @IBOutlet weak var bathroom: UIButton!
    @IBOutlet weak var meetingroom: UIButton!
    var buttonArray = [UIButton]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "필터검색"
        buttonArray = [allnight, dessert,smoking,parkinglot,bathroom,meetingroom]
        designButtonColor(buttonArray: buttonArray)
    }
    
    func designButtonColor(buttonArray : [UIButton]) {
        for button in buttonArray {
            button.layer.cornerRadius = 10
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.init(red: 255, green: 232, blue: 129).cgColor
            button.tintColor = UIColor.clear
            button.setTitleColor(UIColor.init(red: 51, green: 51, blue: 51), for: .normal)
            button.setTitleColor(UIColor.init(red: 51, green: 51, blue: 51), for: .selected)
            button.setBackgroundImage(#imageLiteral(resourceName: "backgrondColor"), for: .selected)
            button.addTarget(self, action: #selector(pickFilter(_:)) , for: .touchUpInside)
        }
    }
    func pickFilter(_ button: UIButton) {
        button.isSelected = !button.isSelected
        print(button.currentTitle)
        
    }

    
    

    
    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func confirmFilter(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

