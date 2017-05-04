//
//  FilterButtonUIView.swift
//  MachumCafe
//
//  Created by   minjae on 2017. 5. 4..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class FilterButtonUIView: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Buttons
        let allnight = UIButton(frame: CGRect(x: 20, y: 20, width: 80, height: 30))
        let dessert = UIButton(frame: CGRect(x: 110, y: 20, width: 80, height: 30))
        let smoking = UIButton(frame: CGRect(x: 20, y: 70, width: 80, height: 30))
        let parkinglot = UIButton(frame: CGRect(x: 110, y: 70, width: 80, height: 30))
        let bathroom = UIButton(frame: CGRect(x: 20, y: 120, width: 80, height: 30))
        let meetingroom = UIButton(frame: CGRect(x: 110, y: 120, width: 80, height: 30))
        
        allnight.backgroundColor = UIColor.red
        dessert.backgroundColor = UIColor.blue
        smoking.backgroundColor = UIColor.red
        parkinglot.backgroundColor = UIColor.blue
        bathroom.backgroundColor = UIColor.red
        meetingroom.backgroundColor = UIColor.blue
        
        
        allnight.addTarget(self, action: #selector(ratingButtonTapped(button:)), for: .touchDown)
        
        addSubview(allnight)
        addSubview(dessert)
        addSubview(smoking)
        addSubview(parkinglot)
        addSubview(bathroom)
        addSubview(meetingroom)
        
    }
    

    func ratingButtonTapped(button: UIButton){
        print("Button pressed")
    }
}
