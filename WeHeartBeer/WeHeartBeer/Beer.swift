//
//  Beer.swift
//  WeHeartBeer
//
//  Created by Fernando H M Bastos on 11/6/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import Foundation
import UIKit
import ParseUI
import Parse

class Beer: PFObject, PFSubclassing {
    
    var name: String!
    var brewery: String!
    var Style: String!
    var IBU: String!
    var Photo: PFFile!
    
    override class func initialize() {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            
        }
        dispatch_once(&Static.onceToken){
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String{
        return "Beer"
    }
        
        // Unwrap the current object
        
        
        
//        // The three special values are provided as properties:
//        let objectId  = object.objectId
//        let updatedAt = object.updatedAt
//        let createdAt = object.createdAt
//        
//        object.fetch()
        
        

}
