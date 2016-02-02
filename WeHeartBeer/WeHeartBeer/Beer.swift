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
    var ABV: String!
    var brewName: String!
    var note: NSNumber?
    var qntyUsr: NSNumber?
    
    

    
    
    // var Photo: UIImage!
    
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
}
