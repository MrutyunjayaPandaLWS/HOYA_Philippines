//
//  HYP_TabBarVC.swift
//  Hoya Phillippines
//
//  Created by syed on 17/02/23.
//

import UIKit

class HYP_TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        

        self.tabBar.layer.masksToBounds = true
        self.tabBar.layer.cornerRadius = 20
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        self.tabBar.layer.backgroundColor = UIColor.white.cgColor
        self.tabBar.layer.shadowColor = UIColor.black.cgColor
        self.tabBar.layer.shadowOffset = .zero
        self.tabBar.layer.shadowOpacity = 0.16
        self.tabBar.layer.shadowRadius = 6
    }

}
