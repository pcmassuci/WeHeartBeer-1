//
//  Friends.swift
//  BeerLove
//
//  Created by Paulo César Morandi Massuci on 20/01/16.
//  Copyright © 2016 Fernando H M Bastos. All rights reserved.
//

import Foundation

class Friends: PFObject, PFSubclassing {
    
    var accepted: Bool!
    var user1: PFObject!
    var id1: String!
    var user2: PFObject!
    var id2: String!
    var name1: String!
    var name2: String!
    
    
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
        return "Friends"
    }
}