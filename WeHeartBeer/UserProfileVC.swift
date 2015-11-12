//
//  UserProfileVC.swift
//  WeHeartBeer
//
//  Created by Matheus Santos Lopes on 06/11/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import UIKit

class UserProfileVC: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
        if UserServices.loggedUser(){
            //self.performSegueWithIdentifier("loginSegue", sender: self)
            print("User logged")
        }
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: true) //or animated: false
        self.navigationController?.navigationBar.hidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func loginNormalClicked(sender: AnyObject) {
        UserServices.loginNormalUser(self.emailField.text!, password: self.passwordField.text!) { (success) -> Void in
            if success{
                self.performSegueWithIdentifier("loginSegue", sender: self)
            }else{
                //TODO
            }
        }
    }
    
    
    @IBAction func loginFacebookClicked(sender: AnyObject) {
        
        UserServices.loginFaceUser { (success) -> Void in
            if success{
                self.performSegueWithIdentifier("loginSegue", sender: self)
            }else{
                //TODO
            }
        }
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

