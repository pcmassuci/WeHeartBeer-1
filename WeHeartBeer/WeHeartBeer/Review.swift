//
//  Review.swift
//  BeerLove
//
//  Created by Matheus Santos Lopes on 11/01/16.
//  Copyright © 2016 Fernando H M Bastos. All rights reserved.
//

import Foundation
import UIKit
import ParseUI
import Parse

class Review: PFObject, PFSubclassing {
    
    var user: PFUser!
    var beer: PFObject!
    var objectID: String!
    var rating: NSNumber!
    
      override class func initialize() {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            
        }
        dispatch_once(&Static.onceToken){
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String{
        return "Review"
    }
}