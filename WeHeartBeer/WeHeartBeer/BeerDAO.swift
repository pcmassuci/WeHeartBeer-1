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
    typealias RegisterBeerCH = (successs:Bool)->Void
    
    
    
    //find beer for name in parse using completionHandler, send a string with name of beer
    
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
    
    
    
    // find beer from brewery,using CH, send a brewery name from parse return objects Beer
    static func findBeerfromBrewery(brewery:String,completionHandler:FindObjectsCompletionHandler){
        
        let query = PFQuery(className: "Beer")
        let pointer = PFObject(withoutDataWithClassName:"Brewery", objectId:brewery)
        
        query.whereKey("brewery", equalTo: pointer)
        
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
    
    
    // under implemention, all under this command is under implemation
    
    
    func searchBeers(search: String!, completionHandler: FindObjectsCompletionHandler){
        
        let query = PFQuery(className: "Beer").whereKey("name", containsString: search)
        query.findObjectsInBackgroundWithBlock { (results: [PFObject]?,error: NSError?) -> Void in
            
            if (error == nil) {
                //self.searchResults.removeAll(keepCapacity: false)
                
                //self.searchResults += results as! [Brewery]
                //print(self.searchResults)
                //                print(self.brewery[0].objectForKey("local") )
                //                self.resultsList = results
                //
                //                self.resultsTable.reloadData()
                //
            } else {
                // Log details of the failure
                print("search query error: \(error) \(error!.userInfo)")
            }
        }
    }
    
    func registerBeer(beer:Beer, completionHandler: RegisterBeerCH){
        
        
        let registerBeer = PFObject(className:"Beer")
        registerBeer["name"] = beer.objectForKey("name")
        
        registerBeer.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                completionHandler(successs: true)
                // The object has been saved.
            } else {
                completionHandler(successs: false)
                
                // There was a problem, check error.description
            }
        }
        
    }
    
}


