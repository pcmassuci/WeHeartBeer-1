//
//  BreweryDAO.swift
//  WeHeartBeer
//
//  Created by Paulo César Morandi Massuci on 09/11/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import UIKit
import Foundation
import Parse


class BeerDAO {
    
    
    
    
    
    typealias FindObjectsCompletionHandler = (beer:[Beer]?,success:Bool) -> Void
    
    
    
    
    
    static func findBeer(beer:String,completionHandler:FindObjectsCompletionHandler){
        
        let query = PFQuery(className: "Beer")
        
        query.whereKey("name", equalTo: beer)
        
        query.findObjectsInBackgroundWithBlock { (result:[PFObject]?, error:NSError?) -> Void in
            if error == nil {
                if let result = result as? [Beer] {
                    completionHandler(beer: result, success: true)
                }else{
                    print("erro dao")
                    completionHandler(beer:nil,success: false)
                }
            }else{
                print("erro dao 2")
                completionHandler(beer:nil,success: false)
            }
            
            
        }
        
    }
}


