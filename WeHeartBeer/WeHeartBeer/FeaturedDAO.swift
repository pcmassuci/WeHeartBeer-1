//
//  FeaturedDAO.swift
//  BeerLove
//
//  Created by Júlio César Garavelli on 28/01/16.
//  Copyright © 2016 Fernando H M Bastos. All rights reserved.
//

import Foundation
import UIKit

class FeaturedDAO{
    
typealias FindObjectsCompletionHandler = (objs:[PFObject]?,success:Bool) -> Void
   
    
    
    static func queryFeatured(ch:FindObjectsCompletionHandler){
        let query = PFQuery(className:"Featured")
        query.whereKey("active", equalTo: true)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Sucesso ao recuperar \(objects!.count) pontuação.")
                ch(objs: objects, success: true)
                // Do something with the found objects
//                if let objects = objects {
//                    
//                    for object in objects {
//                        print(object.objectId)
//                        
//                        print(object.valueForKey("beer")?.objectId)
                
                       // self.queryBeer((object.valueForKey("beer")?.objectId)!)
                        
//                    }
                    //self.configureCollectionView(true)
//                }
            } else {
                ch(objs: nil, success: false)
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }

        
    }
    
}