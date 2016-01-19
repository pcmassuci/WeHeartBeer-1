//
//  ContactVC.swift
//  BeerLove
//
//  Created by Fernando H M Bastos on 1/19/16.
//  Copyright © 2016 Fernando H M Bastos. All rights reserved.
//

import UIKit
import Foundation

class ContactVC: UIViewController {
    
    
    @IBOutlet weak var mailMe: UIButton!
    
    @IBOutlet weak var contactIntro: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.hidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255.0/255.0, green: 192.0/255.0, blue: 3.0/255.0, alpha: 1.0)
        
        self.animateButton()
        
        
    
    }
    
    func animateButton(){
        
        self.mailMe.transform = CGAffineTransformMakeScale(1.0, 1.0)
        UIView.animateWithDuration(2, delay: 0, options: [.Autoreverse, .Repeat, .BeginFromCurrentState, .AllowUserInteraction], animations: {self.mailMe.transform = CGAffineTransformMakeScale(0.7, 0.7)}, completion: {finish in self.animateButton()} )
    
    }
    
    @IBAction func mailMe(sender: UIButton){
        
        
        let url: NSURL = NSURL(string: "mailto:weheartbeerapp@gmail.com")!
        
        UIApplication.sharedApplication().openURL(url)
        
    
    }

    

}
