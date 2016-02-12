//
//  ReviewFriendVCCell.swift
//  BeerLove
//
//  Created by Paulo César Morandi Massuci on 12/02/16.
//  Copyright © 2016 Fernando H M Bastos. All rights reserved.
//

import UIKit

class ReviewFriendVCCell: UITableViewCell {

    @IBOutlet weak var beersFromUser: UILabel!
    @IBOutlet weak var breweryFromUser: UILabel!
    
    @IBOutlet weak var imageBeersFromUser: UIImageView!
    @IBOutlet weak var ratingFromUser: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        imageBeersFromUser.layer.borderWidth = 1
        imageBeersFromUser.layer.masksToBounds = false
        imageBeersFromUser.layer.borderColor = UIColor.blackColor().CGColor
        imageBeersFromUser.clipsToBounds = true
        imageBeersFromUser.layer.cornerRadius = imageBeersFromUser.frame.height/2
        
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
