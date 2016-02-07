//
//  MoreVC.swift
//  BeerLove
//
//  Created by Fernando H M Bastos on 1/12/16.
//  Copyright © 2016 Fernando H M Bastos. All rights reserved.
//

import Foundation
import UIKit



class MoreVC: UITableViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view2 = UIView(frame:
            CGRect(x: 1.0, y: 0.0, width: UIScreen.mainScreen().bounds.size.width, height: UIApplication.sharedApplication().statusBarFrame.size.height)
        )
        
        
        
        view2.backgroundColor = UIColor(red: 250.0/255.0, green: 170.0/255.0, blue: 4.0/255.0, alpha: 1.0)
        self.view.addSubview(view2)
        
        
      //  UIApplication.sharedApplication().setStatusBarStyle
        
        self.navigationController?.navigationBar.hidden = true
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 250.0/255.0, green: 170.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()

       
        
    }

    
  
}