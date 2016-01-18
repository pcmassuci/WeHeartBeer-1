//
//  ReviewServices.swift
//  BeerLove
//
//  Created by Matheus Santos Lopes on 11/01/16.
//  Copyright © 2016 Fernando H M Bastos. All rights reserved.
//

import Foundation
import Parse
import UIKit

class ReviewServices: UIViewController {
    typealias BooleanCompletionHandler = (success:Bool) -> Void
    
    typealias FindObjectsCompletionHandler = (reviews:[Review]?,success:Bool) -> Void
    typealias FindReviewCompletionHandler = (review:[Review]?,success:Bool) -> Void
    typealias FindObjIDCompletionHandler = (review:[Review]?,success:Bool) -> Void
    typealias CreateCompletionHaldler = (success:Bool) -> Void



    
    
    static func findReviewfromUser(user:PFUser,completionHandler:FindObjectsCompletionHandler) {
        
        ReviewDAO.findReviewFromUser(user) { (reviews, success) -> Void in
            
            print(reviews?.count)
            
            
            if success{
                completionHandler(reviews: reviews, success: true)
                  print(reviews)
            }else{
                // alertar o usuario
                print("erooo serivice")
                completionHandler(reviews: nil,success: false)
                
            }
        }
        
    }
    
}
