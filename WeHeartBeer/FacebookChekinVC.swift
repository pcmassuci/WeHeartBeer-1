//
//  FacebookChekinVC.swift
//  LoveBeer
//
//  Created by Matheus Santos Lopes on 26/11/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//


import UIKit
import Foundation
import Parse
import ParseFacebookUtilsV4


class FacebookCheckinVC: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = true
//        let loginButton = FBSDKLoginButton()
//        loginButton.center = self.view.center
//        self.view.addSubview(loginButton)
        
        self.tintBarUp(self.view)
//        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Check if user is logged in
//        if UserServices.loggedUser() {
//             self.navigationController?.popToRootViewControllerAnimated(true)
//        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        if UserServices.loggedUser() {
//        self.navigationController?.popToRootViewControllerAnimated(true)
//            
//                   }
    }
    
    
    @IBAction func loginButton(sender: AnyObject) {
        performLogin()
    }
    
    private func performLogin() {
        UserServices.loginFaceUser { (success) -> Void in
            
            if success {
              self.performSegueWithIdentifier("successLog", sender: nil)
              
            }
        }
    }
    
}



