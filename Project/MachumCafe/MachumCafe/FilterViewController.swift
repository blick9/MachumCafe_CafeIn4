//
//  FilterViewController.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 4. 28..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "필터검색"
        
    }

    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func confirmFilter(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

