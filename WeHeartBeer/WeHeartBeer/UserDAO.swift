//
//  UserDAO.swift
//  WeHeartBeer
//
//  Created by Paulo César Morandi Massuci on 11/11/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import Foundation
import Parse
import ParseFacebookUtilsV4


class UserDAO {
    typealias SignUpCompletionHandler = (success:Bool) -> Void
    
    //vamo ver se vai
    
    
    
    static func insert(user:User,completionHandler:SignUpCompletionHandler){
        
        user.signUpInBackgroundWithBlock { (success, error:NSError?) -> Void in
            if let error = error {
                _ = error.userInfo["error"] as! NSString
                completionHandler(success: false)
            } else {
                completionHandler(success: true)
            }
        }
    }
    
    
    static func logout(completionHandler:SignUpCompletionHandler){
        User.logOutInBackgroundWithBlock { (error:NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo["error"] as? NSString
                completionHandler(success: false)
            } else {
                completionHandler(success: true)
            }
            
            
        }
    }
    
    
    static func loginNormal(username:String,passowrd:String,completionHandler:SignUpCompletionHandler){
        User.logInWithUsernameInBackground(username, password: passowrd) { (user, error:NSError?) -> Void in
            
            if let _ = error {
               // let errorString = error.userInfo["error"] as? NSString
                print("erro")
                completionHandler(success: false)
            } else {
                _ = user as! User
                completionHandler(success: true)
            }
            
            
        }
    }
    
    static func loginFacebook(completionHandler:SignUpCompletionHandler){
        let permissions = ["public_profile"]
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions) {
            (user: PFUser?, error: NSError?) -> Void in
            
            if let user = user {
                
                if user.isNew {
                    print("passou como usario novo")
                    let userNew = user as! User
                    UserDAO.saveNewFBUser(userNew, completionHandler: { (success) -> Void in
                        completionHandler(success: success)
                    })
                }else{
                    print("rolou")
                    
                    completionHandler(success: true)
                }
                
                
            } else {
                print("deu erro")
                completionHandler(success: false)
            }
        }
    }
    
    
    
    
    
    
    
    static func update(user:User,completionHandler:SignUpCompletionHandler){
        user.saveInBackgroundWithBlock { (success, error:NSError?) -> Void in
            completionHandler(success: success)
        }
        
    }
    
    
    static func saveNewFBUser(user:User,completionHandler:SignUpCompletionHandler){
        
        
        
        let params = ["fields": "email,first_name,last_name,gender,picture.width(480).height(480)"]
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: params)
        print("asdas")
        
        graphRequest.startWithCompletionHandler { (connection, result, error) -> Void in
            
            let dict  = result as! NSDictionary
            let name = (dict.valueForKey("first_name") as? String)!
            let lastName = (dict.valueForKey("last_name") as? String)!
            let imageURL = dict.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as! String
            if dict.valueForKey("email") != nil {
                let email = (dict["email"] as! String)
                user.mail = email
                
            }
            
            let data = NSData(contentsOfURL: NSURL(string: imageURL)!)
            let image = UIImage(data: data!)
            let imageData = UIImageJPEGRepresentation(image!, 0)
            let imageFile = PFFile(name:"profile.png", data:imageData!)
            user.name = name + " " + lastName
            user.photo = imageFile!
            
            
            
            UserDAO.update(user, completionHandler: { (success) -> Void in
                completionHandler(success: success)
            })
            
        }
    }
    
    
    
    
}