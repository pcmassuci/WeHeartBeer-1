//
//  Homepage.swift
//  WeHeartBeer
//
//  Created by Júlio César Garavelli on 23/10/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import UIKit

class HomepageVC: UIViewController {
    
    
    // MARK: - IBOutlets
    
    @IBOutlet var challengeLink: UIImageView!
    //@IBOutlet weak var backgroundImageview: UIImageView!
    
    // MARK: - UICollectionViewDataSource
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let gesture = UITapGestureRecognizer(target: self, action: "challengeLinkClicked")
        
        self.challengeLink.addGestureRecognizer(gesture)
        
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - ChallengeLink
    func challengeLinkClicked(){
        performSegueWithIdentifier("challengeSegue", sender: nil)
    }
}


