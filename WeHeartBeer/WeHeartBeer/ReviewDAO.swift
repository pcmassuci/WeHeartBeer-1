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

    typealias FindObjectsCompletionHandler = (reviews:[Review]?,success:Bool) -> Void
    typealias RegisterReviewCH = (success:Bool)->Void
    
    typealias CreateCompletionHaldler = (beer:Beer?,success:Bool) -> Void
    
    
    
    
    // find beer from user,using CH, send a user from parse return objects Beer
    static func findReviewFromUser(user:PFObject,completionHandler:FindObjectsCompletionHandler){
        
    
        
        let query = PFQuery(className: "Review")
        
        query.whereKey("user", equalTo: user)
        query.includeKey("beer")
        query.includeKey("Beer.name")
        
        query.findObjectsInBackgroundWithBlock { (result:[PFObject]?, error:NSError?) -> Void in
        
            if error == nil {
                print(result)

                
                if let result = result as? [Review] {
                    print(result.first!)
                    completionHandler(reviews: result, success: true)
                    print(result)
                }else{
                    print("erro dao")
                    completionHandler(reviews:nil,success: false)
                }
            }else{
                print("erro dao 2")
                completionHandler(reviews:nil,success: false)
            }
            
            
        }
        
    }
    
    
    
    


    
    
    
}



