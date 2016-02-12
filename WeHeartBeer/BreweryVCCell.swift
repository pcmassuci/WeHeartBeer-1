//
//  BreweryVCCell.swift
//  WeHeartBeer
//
//  Created by Paulo César Morandi Massuci on 04/11/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import UIKit

class BreweryVCCell: UITableViewCell {
    
    @IBOutlet weak var addBeer: UILabel!
    @IBOutlet weak var beerStyle: UILabel!
    @IBOutlet weak var beerImg: UIImageView!
    @IBOutlet weak var beersFromBrew: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
