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
        

        self.navigationController?.navigationBar.barTintColor = UIColor(red: 250.0/255.0, green: 170.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()

        
        let gesture = UITapGestureRecognizer(target: self, action: "challengeLinkClicked")
        
        self.challengeLink.addGestureRecognizer(gesture)
        
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true

    }
    
        
    
    // MARK: - ChallengeLink
    func challengeLinkClicked(){
        performSegueWithIdentifier("challengeSegue", sender: nil)
    }
}


