//
//  Homepage.swift
//  WeHeartBeer
//
//  Created by Júlio César Garavelli on 23/10/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import UIKit

class HomepageVC: UIViewController {

    @IBOutlet var challengeLink: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let gesture = UITapGestureRecognizer(target: self, action: "challengeLinkClicked")
        
        self.challengeLink.addGestureRecognizer(gesture)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func challengeLinkClicked(){
        performSegueWithIdentifier("challengeSegue", sender: nil)
    }
    
//OI
    

}
