//
//  ReviewVCCell.swift
//  BeerLove
//
//  Created by Matheus Santos Lopes on 12/01/16.
//  Copyright © 2016 Fernando H M Bastos. All rights reserved.
//


import UIKit


class ReviewVCCell: UITableViewCell {

    @IBOutlet weak var imageBeersFromUser: UIView!
    @IBOutlet weak var beersFromUser: UILabel!
    @IBOutlet weak var breweryFromUser: UILabel!
    @IBOutlet weak var ratingFromUser: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}