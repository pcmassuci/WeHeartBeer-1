//
//  UserServices.swift
//  WeHeartBeer
//
//  Created by Fernando H M Bastos on 11/9/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import Foundation
import Parse
import ParseFacebookUtilsV4



class UserServices {
    typealias SignUpCompletionHandler = (success:Bool) -> Void
  //  typealias FindBandsCompletionHandler = (bands:[Band]?,success:Bool) -> Void
    
    
    static func createUser(email:String,password:String,confirmPassword:String,completionHandler:SignUpCompletionHandler){
        if UserValidation.signUpValidation(email, password: password, confirmPassword: confirmPassword){
            let user = User()
            user.username = email
            user.email = email
            user.password = password
            
            
            UserDAO.insert(user, completionHandler: { (success) -> Void in
                
                
                completionHandler(success: success)
            })
        }else{
            completionHandler(success: false)
        }
    }
    
    
    static func loggedUser()->Bool{
        return PFUser.currentUser()  != nil
    }
    
    
    static func logoutUser(completionHandler:SignUpCompletionHandler){
        UserDAO.logout { (success) -> Void in
            completionHandler(success: success)
        }
    }
    
    
    static func loginNormalUser(username:String,password:String,completionHandler:SignUpCompletionHandler){
        UserDAO.loginNormal(username, passowrd: password) { (success) -> Void in
            completionHandler(success:success)
        }
    }
    
    static func loginFaceUser(completionHandler:SignUpCompletionHandler){
        UserDAO.loginFacebook { (success) -> Void in
            completionHandler(success:success)
        }
    }
    
    
    static func updateUser(name:String!,birthDate:NSDate!,height:Float!,weight:Float!,motivation:String!,completionHandler:SignUpCompletionHandler){
        let user = User.currentUser()
        
        if name != nil{
            user?.name = name
        }
        
        if birthDate != nil{
            user?.birthDate = birthDate
        }
        
        UserDAO.update(user!, completionHandler: { (success) -> Void in
            completionHandler(success: success)
        })
    }
    
    
    static func updateNameUser(name:String,completionHandler:SignUpCompletionHandler){
        let user = User.currentUser()
        
        user?.name = name
        UserDAO.update(user!, completionHandler: { (success) -> Void in
            completionHandler(success: success)
        })
    }
    
    static func updateBirthDateUser(birthDate:NSDate,completionHandler:SignUpCompletionHandler){
        let user = User.currentUser()
        
        user?.birthDate = birthDate
        UserDAO.update(user!, completionHandler: { (success) -> Void in
            completionHandler(success: success)
        })
    }
    
    
    static func updateEmailUser(email:String,completionHandler:SignUpCompletionHandler){
        let user = User.currentUser()
        
        user?.email = email
        UserDAO.update(user!, completionHandler: { (success) -> Void in
            completionHandler(success: success)
        })
        
    }
    
    
    static func updateProfileImageUser(image:UIImage,completionHandler:SignUpCompletionHandler){
        let user = User.currentUser()
        
        let imageData = UIImageJPEGRepresentation(image, 0)
        let imageFile = PFFile(name:"profile.png", data:imageData!)
        user?.photo = imageFile!
        
        UserDAO.update(user!, completionHandler: { (success) -> Void in
            completionHandler(success: success)
        })
        
    }
    
    
    
 
    
    
}