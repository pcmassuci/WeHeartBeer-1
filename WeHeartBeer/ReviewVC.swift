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
import Social

class ReviewVC: UIViewController {
    
    
    @IBOutlet weak var sliderControl: UISlider!
    @IBOutlet var floatRatingView: FloatRatingView!
    @IBOutlet var updatedLabel: UILabel!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var shareFacebook: UISwitch!
    
    var beer : [Beer]! = [Beer]()
    var user = User.currentUser()
    var currentObjectReview: PFObject?
    var reviewObject = PFObject(className:"Review")
    

    let actionSheet = UIAlertController(title: "Teste", message: "My custom Share", preferredStyle: UIAlertControllerStyle.ActionSheet)
    
    var state = false


    override func viewDidLoad() {
        super.viewDidLoad()
        print("review VC")
        print(currentObjectReview)
        self.findReview(currentObjectReview)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 250.0/255.0, green: 170.0/255.0, blue: 0.0/255.0, alpha: 1.0)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: self.view.window)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: self.view.window)
    }
    
    
    @IBAction func saveReview(sender: AnyObject) {

        let alert = UIAlertController(title: "Save Review?", message: "Beer Love", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            //TODO:
            if self.state == false {
                self.saveData(self.currentObjectReview)
                
            }else{
                self.updateData(self.currentObjectReview)
            }
            
            
            if self.shareFacebook.on{
                self.fbShare(self.currentObjectReview)
                
         
            }
        
            self.navigationController?.popViewControllerAnimated(true)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
        
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
                self.state = true
            }else{
                print("Erro ao salvar dados")
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
    
    
    //MARK: - faceShare
    
    
    func fbShare(review: PFObject?){
        
      
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
            let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            
            
            
            let query = PFQuery(className:"Review")
            query.whereKey("user", equalTo:user!)
            query.whereKey("beer", equalTo:review!)
            print(review)
            
            if review!.objectForKey("Photo") != nil{
                let userImageFile = review!.objectForKey("Photo") as! PFFile
                
                userImageFile.getDataInBackgroundWithBlock {
                    (imageData: NSData?, error: NSError?) -> Void in
                    if error == nil {
                        if let imageData = imageData {
                            let image = UIImage(data:imageData)
                            facebookSheet.setInitialText("Frango")
                            //facebookSheet.addURL(<#T##url: NSURL!##NSURL!#>)
                            facebookSheet.addImage(image)
                            
                            self.presentViewController(facebookSheet, animated: true, completion: nil)
                        }else{
                            print("erro na imagem")
                        }
                    }
                    
                }
            }else{
                print("sem imagem")
            }
            
            
            
            
        }
    }
    
}




//MARK: - KEYBOARDS METHODS
extension ReviewVC{
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    func keyboardWillShow(sender: NSNotification) {
        let userInfo: [NSObject : AnyObject] = sender.userInfo!
        
        let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
        let offset: CGSize = userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue.size
        
        if keyboardSize.height == offset.height {
            if self.view.frame.origin.y == 0 {
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.view.frame.origin.y -= keyboardSize.height - 70
                })
            }
        } else {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.view.frame.origin.y += keyboardSize.height - offset.height - 70
            })
        }
        print(self.view.frame.origin.y)        }
    
}

