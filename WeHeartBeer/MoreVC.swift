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
            CGRect(x: 4.0, y: 0.0, width: UIScreen.mainScreen().bounds.size.width, height: UIApplication.sharedApplication().statusBarFrame.size.height)
        )
        
        self.tableView.tableFooterView = UIView()

        
        view2.backgroundColor = UIColor(red: 250.0/255.0, green: 170.0/255.0, blue: 4.0/255.0, alpha: 1.0)
        self.view.addSubview(view2)
       //UIApplication.sharedApplication().statusBarStyle
        
        
       UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.Default, animated: true)
        
        self.navigationController?.navigationBar.hidden = false
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()

       
        
    }
  
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row{
        case 0:
            UserDAO.logout({ (success) -> Void in
                self.alert("Atenção", message: "Você deslogou do Facebook", option: false, action: nil)
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
            })
            break
        default:
            break
        }
    }


    
  
}