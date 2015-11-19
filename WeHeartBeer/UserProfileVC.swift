//
//  UserProfileVC.swift
//  WeHeartBeer
//
//  Created by Matheus Santos Lopes on 06/11/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import UIKit
import Foundation
import Parse
import ParseFacebookUtilsV4


class UserProfileVC: UIViewController {
    

    
    //butons
    //@IBOutlet weak var facebookLoginButton: UIButton!
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
        
        //facebookLoginButton.layer.cornerRadius = self.layer
        //loginButton.layer.cornerRadius = self.layer
            }
    
    
    
    @IBAction func loginButton(sender: UIButton) {
        
        let permissions = ["public_profile", "email", "user_friends"]
        
        
        
        
        // Log In with Read Permissions
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions, block: {
            (user: PFUser?, error: NSError?) -> Void in
            if let user = user {
                if user.isNew {
                    FBUtils.updateFacebookProfile()
                    FBUtils.updateFacebookPicture()
                    print("User signed up and logged in through Facebook!")
                    self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    FBUtils.updateFacebookProfile()
                    print("User logged in through Facebook!")
                }
            } else {
                print("Uh oh. The user cancelled the Facebook login.")
            }
        })
        
        

    
    }
    
    // MARK: Actions
    

    
    
//    func logInAction(sender: AnyObject) {
//        
//        let username = "matheus.thc@gmail.com"
//        let password = "97630089"
//        
//        //Log In attempt
//        self.activityIndicator.startAnimating()
//        
//        PFUser.logInWithUsernameInBackground(username, password: password, block: { (user, error) -> Void in
//            
//            
//            self.activityIndicator.stopAnimating()
//            
//            var alert = UIAlertController()
//            var okButtom = UIAlertAction()
//            
//            if (user != nil) {
//                
//                alert = UIAlertController(title: "Success", message: "Logged In", preferredStyle: .Alert)
//                
//                okButtom = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { (okAction:UIAlertAction!) -> Void in
//                    
//                    self.performSegueWithIdentifier("profileSegue", sender: nil)
//                    
//                })
//                
//            } else {
//                
//                alert = UIAlertController(title: "Oops..", message: "\(error?.userInfo)", preferredStyle: .Alert)
//                okButtom = UIAlertAction(title: "Ok", style: .Default, handler: nil)
//                
//            }
//            
//            
//            alert.addAction(okButtom)
//            self.presentViewController(alert, animated: true, completion: nil)
//        })
//    }
}

