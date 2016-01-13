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
    
    typealias FindObjectsCompletionHandler = (review:[Review]?,success:Bool) -> Void
    typealias FindReviewCompletionHandler = (review:[Review]?,success:Bool) -> Void
    typealias FindObjIDCompletionHandler = (review:[Review]?,success:Bool) -> Void
    typealias CreateCompletionHaldler = (success:Bool) -> Void
    
    
    //typealias FindObjIDCompletionHandler = (brewery:Brewery?,success:Bool) -> Void


    
    
    static func findReviewfromUser(User:String,completionHandler:FindObjectsCompletionHandler) {
        ReviewDAO.findReviewFromUser(User) { (Review, success) -> Void in
            
            print(Review)
            
            
            if success{
                completionHandler(review: Review, success: true)
                  print(Review)
            }else{
                // alertar o usuario
                print("erooo serivice")
                completionHandler(review: nil,success: false)
                
            }
        }
        
    }
    
}
