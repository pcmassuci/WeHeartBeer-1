//
//  Brewery.swift
//  WeHeartBeer
//
//  Created by Fernando H M Bastos on 11/9/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import Foundation
import Parse
import UIKit


class Brewery: PFObject, PFSubclassing
{
    var name: String!
//  var beers:PFObject!
    var photo:UIImage!
    var contact: String!
    var local: String!
    var objectID:String!
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return "Brewery"
    }
    
    
    
}