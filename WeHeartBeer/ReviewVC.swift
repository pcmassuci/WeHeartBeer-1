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
    @IBOutlet var floatRatingView: FloatRatingView!
    @IBOutlet var updatedLabel: UILabel!
    @IBOutlet weak var commentText: UITextField!
    
    var beer : [Beer]! = [Beer]()
    var user = User.currentUser()
    var currentObjectReview: PFObject?
    var reviewObject = PFObject(className:"Review")
    
    var state = false
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("review VC")
        print(currentObjectReview)
        self.findReview(currentObjectReview)


    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    @IBAction func saveReview(sender: AnyObject) {
        
        if self.state == false {
            saveData(currentObjectReview)
        }else{
            updateData(currentObjectReview)
        }
        
    }
    
    
    @IBAction func sliderControl(sender: UISlider) {
        let currentValue = roundf(sender.value / 0.2) * 0.25
        updatedLabel.text = String(format: "%.2f", currentValue)
        self.floatRatingView.rating = Float(currentValue)
    }
    

    
    
    func findReview (review: PFObject?) -> Bool {
        
        let query = PFQuery(className:"Review")
        query.whereKey("user", equalTo:user!)
        query.whereKey("beer", equalTo:review!)
        print(review)
        self.state = false
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                if objects!.count > 0 {
                    self.reviewObject = objects![0]
                    
                    self.commentText.text = self.reviewObject["comment"] as? String
                    self.floatRatingView.rating = (self.reviewObject["rating"] as? Float)!
                    self.sliderControl.value = (self.reviewObject["rating"] as? Float)!
                    self.updatedLabel.text = String(self.reviewObject["rating"])
                    
                    self.state = true
                    print(self.state)
                }
            }
        }
        return state
    }
    //
    
    
    
    // update informations
    func saveData(beer: PFObject?){
        
        
        
        reviewObject["user"] = user
        reviewObject["beer"] = currentObjectReview
        reviewObject["rating"] = Double(updatedLabel.text!)
        reviewObject["comment"] = commentText.text
        reviewObject.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                print("deu")
                self.state = true
            } else {
                // There was a problem, check error.description
            }
        }
        
    }
    

    
    // update informations
    func updateData(review: PFObject?){


        
        reviewObject["user"] = self.user
        reviewObject["beer"] = self.currentObjectReview
        reviewObject["rating"] = Double(self.updatedLabel.text!)
        reviewObject["comment"] = self.commentText.text
        reviewObject.saveInBackground()
        
        
    }
    
}



