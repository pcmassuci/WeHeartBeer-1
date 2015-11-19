//
//  File.swift
//  WeHeartBeer
//
//  Created by Júlio César Garavelli on 17/11/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import Parse
import ParseUI

class FBUtils: NSObject {
    
    static func updateFacebookProfile() {
        
        let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id, email, first_name, last_name, picture"])
        request.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if error != nil {
                // Some error checking here
            } else if let userData = result as? [String:AnyObject] {
                // Access user data
                let email = userData["email"] as! String
                let displayName = (userData["first_name"] as! String) + " " + (userData["last_name"] as! String)
                
                let currentUser = PFUser.currentUser()
                
                if currentUser != nil {
                    
                    currentUser?.setObject(displayName, forKey: "displayName")
                    currentUser?.email = email
                    
                    currentUser?.saveInBackgroundWithBlock({ (success, error) -> Void in
                        
                        if error != nil {
                            
                            print("SUCESSO MAROTAGEM!!")
                            
                        } else {
                            // Some error checking here
                            print("erro pra salvar: \(error?.userInfo)")
                        }
                        
                    })
                    
                } else {
                    // Some error checking here
                    print("erro usuario nil: \(error.userInfo)")
                }
                
            }
        })
        
    }
    
    static func updateFacebookPicture() {
        
        let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id, email, first_name, last_name, picture"])
        request.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if error != nil {
                // Some error checking here
            } else if let _ = result as? [String:AnyObject] {
                // Access user data
                let userID: NSString = result.valueForKey("id") as! NSString
                
                let currentUser = PFUser.currentUser()
                
                if currentUser != nil {
                    
                    let facebookImageData: NSData = self.returnUserProfileImage(userID)
                    currentUser?.setObject((PFFile(data: facebookImageData))!, forKey: "image")
                    
                    
                    currentUser?.saveInBackgroundWithBlock({ (success, error) -> Void in
                        
                        if error != nil {
                            
                            print("SUCESSO MAROTAGEM!!")
                            
                        } else {
                            // Some error checking here
                            print("erro pra salvar image: \(error?.userInfo)")
                        }
                        
                    })
                    
                } else {
                    // Some error checking here
                    print("erro usuario nil")
                }
                
            }
            
        })
        
    }
    
    static func returnUserProfileImage(accessToken: NSString)-> NSData {
        
        let userID = accessToken as String
        let facebookProfileUrl = NSURL(string: "http://graph.facebook.com/\(userID)/picture?type=large")
        
        if let data = NSData(contentsOfURL: facebookProfileUrl!) {
            return data
        }
        
        return NSData()
    }
}
