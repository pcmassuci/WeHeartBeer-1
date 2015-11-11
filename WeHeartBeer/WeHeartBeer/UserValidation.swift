//
//  UserValidation.swift
//  WeHeartBeer
//
//  Created by Paulo César Morandi Massuci on 11/11/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import Foundation


class UserValidation {
    
    
    static func usernameValidation(username:String)-> Bool{
        return !username.isEmpty
    }
    static func emailValidation(email:String)-> Bool{
        return !email.isEmpty
    }
    
    static func passwordValidation(password:String,confirmPassword:String)-> Bool{
        return !password.isEmpty && password == confirmPassword
    }
    
    
    static func signUpValidation(email:String, password:String, confirmPassword:String)->Bool{
        return self.usernameValidation(email) && self.passwordValidation(password, confirmPassword: confirmPassword)
    }
}