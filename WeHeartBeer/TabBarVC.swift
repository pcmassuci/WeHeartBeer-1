//
//  TabBarVC.swift
//  BeerLove
//
//  Created by Matheus Santos Lopes on 30/11/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        
        let colour = UIColor(red: 255.0/255.0, green: 192.0/255.0, blue: 3.0/255.0, alpha: 1.0)
        self.tabBar.barTintColor = colour
        
        self.tabBar.tintColor = UIColor.blackColor()
    }
}
