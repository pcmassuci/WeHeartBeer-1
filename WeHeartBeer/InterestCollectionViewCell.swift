//
//  InterestCollectionViewCell.swift
//  WeHeartBeer
//
//  Created by Júlio César Garavelli on 29/10/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import UIKit

class InterestCollectionViewCell: UICollectionViewCell
{
    // MARK: - Public API
    var interest: Interest! {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Private
    @IBOutlet weak var featuredImageView: UIImageView!
    
    private func updateUI()
    {
        featuredImageView?.image! = interest.featuredImage
    }
    
}
