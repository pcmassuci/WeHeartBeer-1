//
//  Interest.swift
//  WeHeartBeer
//
//  Created by Júlio César Garavelli on 29/10/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import UIKit

class Interest
{
    // MARK: - Public API
    var featuredImage: UIImage!
    
    init(featuredImage: UIImage!)
    {
        self.featuredImage = featuredImage
    }
    
    // MARK: - Private
    // dummy data
    static func createInterests() -> [Interest]
    {
        return [
            
            Interest(featuredImage: UIImage(named: "beer1")!),
            Interest(featuredImage: UIImage(named: "beer2")!),
            Interest(featuredImage: UIImage(named: "beer3")!),
            Interest(featuredImage: UIImage(named: "beer4")!),
            Interest(featuredImage: UIImage(named: "beer5")!),
            Interest(featuredImage: UIImage(named: "beer6")!),
            Interest(featuredImage: UIImage(named: "beer7")!),
        ]
    }
}

