//
//  ReviewVC.swift
//  BeerLove
//
//  Created by Fernando H M Bastos on 12/3/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import UIKit
import Foundation
import Parse
import ParseFacebookUtilsV4

class ReviewVC: UIViewController {
    
    
    @IBOutlet weak var sliderControl: UISlider!
    @IBOutlet var ratingSegmentedControl: UISegmentedControl!
    @IBOutlet var floatRatingView: FloatRatingView!
    @IBOutlet var liveLabel: UILabel!
    @IBOutlet var updatedLabel: UILabel!
        @IBOutlet weak var commentText: UITextField!
    
    var beer : [Beer]! = [Beer]()
    var user = PFUser.currentUser()
    var currentObjectReview: PFObject?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("review VC")
        print(currentObjectReview)

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    @IBAction func saveReview(sender: AnyObject) {
        saveData(currentObjectReview)
        
    }
    
    
    @IBAction func sliderControl(sender: UISlider) {
        let currentValue = roundf(sender.value / 0.2) * 0.25
        updatedLabel.text = String(format: "%.2f", currentValue)
        self.floatRatingView.rating = Float(currentValue)
    }
    

    // update informations
    func saveData(beer: PFObject?){
        
        let beerReview = PFObject(className:"Review")
        
        beerReview["user"] = user
        beerReview["beer"] = currentObjectReview
        beerReview["rating"] = Double(updatedLabel.text!)
        beerReview["comment"] = commentText.text
        beerReview.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                print("deu")
            } else {
                // There was a problem, check error.description
            }
        }
        
        
        
    }
    
    
    
    
    
  
        
    }
    
    

