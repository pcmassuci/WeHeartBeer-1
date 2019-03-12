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
//    
//    
//    
//    @IBOutlet weak var log: UILabel!
//   
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//       
//        
//        let view2 = UIView(frame:
//            CGRect(x: 4.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: UIApplication.sharedApplication.statusBarFrame.size.height)
//        )
//        
//        self.tableView.tableFooterView = UIView()
//
//        
//        view2.backgroundColor = UIColor(red: 250.0/255.0, green: 170.0/255.0, blue: 4.0/255.0, alpha: 1.0)
//        self.view.addSubview(view2)
//       //UIApplication.sharedApplication().statusBarStyle
//        
//        
//        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.default, animated: true)
//        
//        self.navigationController?.navigationBar.isHidden = false
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.navigationBar.tintColor = UIColor.white
//
//       
//        
//    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        if NetService.loggedUser(){
//            self.log.text = "Log out"
//        }else{
//            self.log.text = "Log in"
//        }
//        
//    }
//  
//     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        switch indexPath.row{
//        case 0:
//            
//            if NetService.loggedUser(){
//                NetService.logoutUser(completionHandler: { (success) -> Void in
//                    if success{
//                        self.alert(title: "Atenção", message: "Você deslogou do Facebook", option: false, action: nil)
//                        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
//                        self.log.text = "Log in"
//
//                    }
//                    
//                })
//                
//            }else{
//                NetService.loginFaceUser(completionHandler: { (success) -> Void in
//                    if success{
//                        self.alert(title: "Atenção", message: "Você logou com o Facebook", option: false, action: nil)
//                        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
//                        self.log.text = "Log out"
//                        
//                    }
//                })
//                
//            }
//            
//          
//            break
//        default:
//            break
//        }
//    }
//
//
//    
//  
}
