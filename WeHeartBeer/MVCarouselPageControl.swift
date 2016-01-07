//
//  MVCarouselPageControl.swift
//  BeerLove
//
//  Created by Júlio César Garavelli on 06/01/16.
//  Copyright © 2016 Fernando H M Bastos. All rights reserved.
//

import UIKit


// MARK: Carousel Page Control
class MVCarouselPageControl: UIPageControl {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.pageIndicatorTintColor = UIColor.grayColor()
        self.currentPageIndicatorTintColor = UIColor.blackColor()
        self.hidesForSinglePage = true
    }
}

