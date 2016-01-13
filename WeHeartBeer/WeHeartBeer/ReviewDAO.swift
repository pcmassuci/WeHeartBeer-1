//
//  ReviewDAO.swift
//  BeerLove
//
//  Created by Matheus Santos Lopes on 11/01/16.
//  Copyright © 2016 Fernando H M Bastos. All rights reserved.
//

import UIKit
import Foundation
import Parse

class ReviewDAO: UIViewController {

    typealias FindObjectsCompletionHandler = (review:[Review]?,success:Bool) -> Void
    typealias RegisterReviewCH = (success:Bool)->Void
    
    typealias CreateCompletionHaldler = (beer:Beer?,success:Bool) -> Void
    
    
    
    
    // find beer from user,using CH, send a user from parse return objects Beer
    static func findReviewFromUser(User:String,completionHandler:FindObjectsCompletionHandler){
        
        let userObject = PFUser.objectWithoutDataWithObjectId(User)
        
        let query = PFQuery(className: "Review")
        query.whereKey("user", equalTo: userObject)
        
        
        query.findObjectsInBackgroundWithBlock { (result:[PFObject]?, error:NSError?) -> Void in
            if error == nil {
                
                for object in result! {
                    print(object)
                    let review = object as! Review
                    print(review)
                }
                
                
                if let result = result as? [Review] {
                    completionHandler(review: result, success: true)
                    print(result)
                }else{
                    print("erro dao")
                    completionHandler(review:nil,success: false)
                }
            }else{
                print("erro dao 2")
                completionHandler(review:nil,success: false)
            }
            
            
        }
        
    }
    
    
    
    

    
}



