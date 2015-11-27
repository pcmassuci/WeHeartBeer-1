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
        
         }
    
        @IBAction func loginButton(sender: AnyObject) {
    
    
    
            UserServices.loginFaceUser { (success) -> Void in
                if success{
                    print("Deu Certo facechekin")
                   
                  self.performSegueWithIdentifier("userProfileSegue", sender: nil)
    
    
                }else{
                    print("cancelar facechekin")
                    
                }
    
                
            }
            
        }
    
    
}


