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
        let tabBar = self.tabBar
        tabBar.clipsToBounds = true
        for tabBarItem in tabBar.items! {
            // Adjust tab images (Like mstysf says, these values will vary)
            tabBarItem.imageInsets = UIEdgeInsets(top: 6.5, left: 0, bottom: -6.5, right: 0);
            
            tabBarItem.title = ""
            
            // Let's find and set the icon's default and selected states
            // (use your own image names here)
            var imageName = "lupulo"
//            switch (i) {
//            case 0: imageName = "lupulo"
//            case 1: imageName = "search"
//            case 2: imageName = "user"
//            case 3: imageName = "more"
//            //case 4: imageName = "tab_item_feature_5"
//            default: break
//            }
            tabBarItem.image = UIImage(named:imageName)!.withRenderingMode(.alwaysOriginal)
            tabBarItem.selectedImage = UIImage(named:imageName + "_selected")!.withRenderingMode(.alwaysOriginal)
        }

        
        
    }

    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        
        let index = tabBarController.selectedIndex
        if index == 2 {
//            if NetService.loggedUser(){
//                print("logado")
//            }else{
//                print("nao logado")
//            }
        } else{
        
      
        
        //direct cast - no issue with VC not connectec to navController
        let navController = viewController as! UINavigationController
        
        //pop the view to root
            navController.popToRootViewController(animated: true)
        
    }
    }
    
    
}
