//
//  TabBarVC.swift
//  BeerLove
//
//  Created by Matheus Santos Lopes on 30/11/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import Foundation
import UIKit

class TabBarVC: UITabBarController, UITabBarControllerDelegate {

    
    let navCont = UINavigationController()
    
    override func viewDidLoad() {
        
        self.delegate = self
        
        let colour = UIColor(red: 250.0/255.0, green: 170.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        self.tabBar.barTintColor = colour
        
        self.tabBar.tintColor = UIColor.blackColor()
    }
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        
        //direct cast - no issue with VC not connectec to navController
        let navController = viewController as! UINavigationController
        
        //pop the view to root
        navController.popToRootViewControllerAnimated(true)
        
    }
    
    
}
