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

class ReviewDAO {
    
    typealias FindRatingAndReviewsCompletionHandler = (reviews:[PFObject]?,rate:Float, success:Bool) -> Void
    typealias FindObjectsCompletionHandler = (reviews:[Review]?,success:Bool) -> Void
    typealias RegisterReviewCH = (success:Bool)->Void
    typealias CreateCompletionHaldler = (beer:Beer?,success:Bool) -> Void
    typealias FindReviews = (beer:[PFObject]?, success:Bool) -> Void
    typealias FindObjsCompletionHandler = (reviews:[PFObject]?,success:Bool) -> Void
    
    // find beer from user,using CH, send a user from parse return objects Beer
    static func findReviewFromUser(user:PFObject,completionHandler:FindObjectsCompletionHandler){
        
        let query = PFQuery(className: "Review")
        
        query.whereKey("user", equalTo: user)
        query.includeKey("beer")
        query.includeKey("Beer.name")
        query.includeKey("Beer.brewery")
        query.includeKey("Beer.Photo")
        query.includeKey("Review.rating")
        
        query.findObjectsInBackgroundWithBlock { (result:[PFObject]?, error:NSError?) -> Void in
        
            if error == nil {
                if let result = result as? [Review] {
                    completionHandler(reviews: result, success: true)
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
    
    static func findRevFromUser(user:PFObject?, ch:FindObjsCompletionHandler){
        let query = PFQuery(className: "Review")
        query.whereKey("user", equalTo: user!.objectId!)
            
    }
    

    static func findReviewsFromBeer(beer:PFObject?,ch:FindReviews) {
        
        let query = PFQuery(className:"Review")
        query.whereKey("beer", equalTo:beer!)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                ch(beer: objects, success: true)
                print("Successfully retrieved que eu qeri \(objects!.count) scores.")
            }else{
               ch(beer: nil, success: false)
            }
        }
    }
    
    
    static func findReviewAndRating(beer:PFObject,ch:FindRatingAndReviewsCompletionHandler){
        
        let query = PFQuery(className: "Review")
         query.whereKey("beer", equalTo: beer)
        query.includeKey("user")
        query.includeKey("photo")
        query.findObjectsInBackgroundWithBlock { (objs:[PFObject]?, error) -> Void in
            if error == nil{
            let rating = self.calculateRate(objs)
                print("a média: \(rating)")
                ch(reviews: objs, rate: rating, success: true)
                
            }else{
                ch(reviews: nil, rate: 0, success: false)
            }
        }
    }
    
    
    private static func calculateRate(objs:[PFObject]?) -> Float
    {
        if objs == nil{
           
            return 0
        } else {
//             let objects = objs!
            let cnt = objs!.count
            if cnt == 0{
                return 0
            }else
            {
                var plus = 0 as Float
                for obj in objs!{
                    let alpha = obj.valueForKey("rating") as! Float
                 plus += alpha
                }
                
                plus = (plus / Float(cnt))
                return plus
            }
        }
    }
}

    




