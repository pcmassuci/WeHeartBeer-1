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

class Beer: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var brewery: UILabel!
    @IBOutlet weak var Style: UILabel!
    @IBOutlet weak var IBV: UILabel!
    @IBOutlet weak var Photo: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Unwrap the current object
        //let object = NSObject()
        
//            name.text = object["name"] as! String
//            brewery.text = object["brewery"] as! String
//            Style.text = object["Style"] as! String
//            IBV.text = object["IBV"] as! String
//            Photo.images = object["Photo"] as! UIImageView
        
        
//        // The three special values are provided as properties:
//        let objectId  = object.objectId
//        let updatedAt = object.updatedAt
//        let createdAt = object.createdAt
//        
//        object.fetch()
        
        
    }

}
