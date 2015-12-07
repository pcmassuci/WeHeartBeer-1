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

    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Check if user is logged in
        if UserServices.loggedUser() {
            self.performSegueWithIdentifier("userProfileSegue", sender: nil)
        }
    }
    
    @IBAction func loginButton(sender: AnyObject) {
        performLogin()
    }
    
    private func performLogin() {
        UserServices.loginFaceUser { (success) -> Void in
            if success {
                print("Deu Certo facecheckin")
                self.performSegueWithIdentifier("userProfileSegue", sender: nil)
            } else {
                print("cancelar facechekin")
                
            }
        }
    }
}


