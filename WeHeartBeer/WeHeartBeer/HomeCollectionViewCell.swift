//
//  HomeCollectionViewCell.swift
//  BeerLove
//
//  Created by Paulo César Morandi Massuci on 04/02/16.
//  Copyright © 2016 Fernando H M Bastos. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var featureImage: UIImageView!
    @IBOutlet weak var featuredName: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        let screenHeight = UIScreen.mainScreen().bounds.height
        print(screenHeight)
    
        switch screenHeight {
        case 480:
    
            self.featuredName.font = UIFont(name: "Lato", size: 30)
    
    
        default: // rest of screen sizes
            break
    }
    }
}
