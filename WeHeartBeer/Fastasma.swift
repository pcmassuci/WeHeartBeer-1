//
//  LoginViewController.swift
//  challengeiii
//
//  Created by Júlio César Garavelli on 05/11/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import UIKit
import Parse

class Fantasma: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    //butons
    @IBOutlet weak var facebookLoginButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150))
    
    //layer
    let layer:CGFloat = 7
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Activity Indicator setup
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(self.activityIndicator)
        
        facebookLoginButton.layer.cornerRadius = self.layer
        loginButton.layer.cornerRadius = self.layer
        
    }
    
    // MARK: Actions
    
    @IBAction func logInWithFacebookAction(sender: AnyObject) {
        
        let permissions = ["public_profile", "email", "user_friends"]
        
        //        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions, block: { (user: PFUser?, error: NSError?) -> Void in
        //            if let user = user {
        //                if user.isNew {
        //                    //signed up and logged in
        //                    FBUtils.updateFacebookProfile()
        //                    FBUtils.updateFacebookPicture()
        //
        //                    let alert = UIAlertView(title: "Success", message: "You've been signed up successfully!", delegate: self, cancelButtonTitle: "Ok")
        //                    alert.show()
        //
        //                    self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
        //                } else {
        //                    //logged in
        //                    FBUtils.updateFacebookProfile()
        //
        //                    let alert = UIAlertView(title: "Success", message: "You've been logged in successfully!", delegate: self, cancelButtonTitle: "Ok")
        //                    alert.show()
        //
        //                    self.performSegueWithIdentifier("profileSegue", sender: nil)
        //                }
        //            } else {
        //                //cancelled login
        //                let alert = UIAlertView(title: ":(", message: "Either you cancelled the login or some error occurred. Try again in a few moments!", delegate: self, cancelButtonTitle: "Ok")
        //                alert.show()
        //            }
        //        })
        //    }
        
        
        func logInAction(sender: AnyObject) {
            
            let username = self.usernameField.text
            let password = self.passwordField.text
            
            //Log In attempt
            self.activityIndicator.startAnimating()
            
            PFUser.logInWithUsernameInBackground(username!, password: password!, block: { (user, error) -> Void in
                
                
                self.activityIndicator.stopAnimating()
                
                var alert = UIAlertController()
                var okButtom = UIAlertAction()
                
                if (user != nil) {
                    
                    alert = UIAlertController(title: "Success", message: "Logged In", preferredStyle: .Alert)
                    
                    okButtom = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { (okAction:UIAlertAction!) -> Void in
                        
                        self.performSegueWithIdentifier("profileSegue", sender: nil)
                        
                    })
                    
                } else {
                    
                    alert = UIAlertController(title: "Oops..", message: "\(error?.userInfo)", preferredStyle: .Alert)
                    okButtom = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                    
                }
                
                
                alert.addAction(okButtom)
                self.presentViewController(alert, animated: true, completion: nil)
            })
        }
    }
    
}