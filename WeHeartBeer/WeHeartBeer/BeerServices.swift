//
//  BreweryServices.swift
//  WeHeartBeer
//
//  Created by Fernando H M Bastos on 11/9/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import Foundation
import Parse
import UIKit



class BeerServices {
    
    typealias BooleanCompletionHandler = (success:Bool) -> Void
    typealias FindObjectsCompletionHandler = (beer:[Beer]?,success:Bool) -> Void
    typealias CreateCompletionHaldler = (beer:Beer?,success:Bool) -> Void
    typealias FindBeerCompletionHandler = (beer:[Beer]?,success:Bool) -> Void
    
    
    static func findBeerName(beer:String,completionHandler:FindBeerCompletionHandler){
        
        BeerDAO.findBeer(beer) { (beerCH, success) -> Void in
            
            if success {
                
                completionHandler(beer: beerCH,success: true)
                
            } else {
                
                print("erooo serivice")
                completionHandler(beer: nil,success: false)
                
            }
            
            
            
        }
        
        
        
    }
    
    
    
    
    
    
    
}










