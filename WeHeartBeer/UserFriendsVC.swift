//
//  UserFriendsVC.swift
//  BeerLove
//
//  Created by Fernando H M Bastos on 12/9/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

import FBSDKShareKit

import ParseFacebookUtilsV4


class UserFriendsVC: UIViewController {

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        
        
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me",     parameters: nil)
        graphRequest.startWithCompletionHandler { (connection, result:AnyObject!, error) -> Void in
            
            
                        if ((error) != nil)
                        {
                            // Process error
                            print("Error: \(error)")
                        }
                        else
                        {
                            //get Facebook ID
                            let faceBookID: NSString = result.valueForKey("id") as! NSString
                            //get username
                            let userName : NSString = result.valueForKey("name") as! NSString
                            //get facebook friends who use app
                            let friendlist: AnyObject = (result.valueForKey("friends")! as AnyObject)
                           
                            print(friendlist)
                        }
        
        }


        
        
        
        
        
    }
}
