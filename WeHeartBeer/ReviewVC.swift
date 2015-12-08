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
    var reviewObject:PFObject!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("review VC")
        print(currentObjectReview)
        if self.findReview(currentObjectReview) {
            updatedLabel.text! = reviewObject["rating"] as! String
            commentText.text = reviewObject["comment"] as? String

            
        }else{
            print("teste")
            
        }
        

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
    func updateData(review: PFObject?){
        
        
        
        
       // self.floatRatingView.rating = review!.objectForKey("name") as? String
        

        
        
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
    

    func findReview (review: PFObject?) -> Bool {
        
        let query = PFQuery(className:"Review")
        query.whereKey("user", equalTo:user!)
        query.whereKey("beer", equalTo:review!)
        print(review)
        var state = false

        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                if objects!.count > 0 {
                self.reviewObject = objects![0]
                // Do something with the found objects
//                if let objects = objects {
//                    for object in objects {
//                        print(object.objectId)
                    //self.updatedLabel.text! = self.reviewObject["rating"] as! String
                    self.commentText.text = self.reviewObject["comment"] as? String
                    

                   state = true
                    print(state)
                }
            }
        }
        
        return state

    }
    
}



