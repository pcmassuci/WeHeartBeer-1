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


class BreweryDAO {
    
    

   
    
    typealias FindObjectsCompletionHandler = (brewery:[Brewery]?,success:Bool) -> Void
    
    
   
    
    
    static func findBrewery(brewery:String,completionHandler:FindObjectsCompletionHandler){
        
        let query = PFQuery(className: "Brewery")
        
        query.whereKey("name", equalTo: brewery)
        
        query.findObjectsInBackgroundWithBlock { (result:[PFObject]?, error:NSError?) -> Void in
            if error == nil {
                if let result = result as? [Brewery] {
                    completionHandler(brewery: result, success: true)
                }else{
                    print("erro dao")
                    completionHandler(brewery:nil,success: false)
                }
            }else{
                print("erro dao 2")
                completionHandler(brewery:nil,success: false)
            }
            
            
        }
        
    }
}
        

