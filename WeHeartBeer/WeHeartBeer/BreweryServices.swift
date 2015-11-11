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



class BreweryServices {
    
typealias BooleanCompletionHandler = (success:Bool) -> Void
typealias FindObjectsCompletionHandler = (brewerys:[Brewery]?,success:Bool) -> Void
typealias CreateCompletionHaldler = (brewery:Brewery?,success:Bool) -> Void
typealias FindBandCompletionHandler = (brewery:[Brewery]?,success:Bool) -> Void


static func findBreweryName(brewery:String,completionHandler:FindBandCompletionHandler){
    
    BreweryDAO.findBrewery(brewery) { (breweryCH, success) -> Void in
        
        if success {
            
            completionHandler(brewery: breweryCH,success: true)
            
        } else {
            
            print("erooo serivice")
            completionHandler(brewery: nil,success: false)
            
        }
        
        
        
    }
   
  

}







}










