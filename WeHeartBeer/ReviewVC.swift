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

import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit



class ReviewVC: UIViewController {
    
    
    
    
    
    @IBOutlet weak var sliderControl: UISlider!
    
    @IBOutlet var floatRatingView: FloatRatingView!
    
    @IBOutlet var updatedLabel: UILabel!
    
    @IBOutlet weak var commentText: UITextField!
    
    @IBOutlet weak var shareFacebook: UISwitch!
    
    @IBOutlet weak var giveScore: UILabel!
    
    @IBOutlet weak var commentTite: UILabel!
    
    @IBOutlet weak var introText: UILabel!
    
    @IBOutlet weak var shareText: UILabel!
    
    var beer : [Beer]! = [Beer]()
    
    var user = User.currentUser()
    
    var currentObjectReview: PFObject?
    
    var reviewObject = PFObject(className:"Review")
    
    var textFieldHeightSize = 0.0 as CGFloat
    
    
    
    
    //    let actionSheet = UIAlertController(title: "Teste", message: "My custom Share", preferredStyle: UIAlertControllerStyle.ActionSheet)
    
    
    
    var state = false
    
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tintBarUp(self.view)
        
        print("review VC")
        
        print(currentObjectReview)
        
        self.findReview(currentObjectReview)
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 250.0/255.0, green: 170.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
     
        let screenHeight = UIScreen.mainScreen().bounds.height
        print(screenHeight)
        
        switch screenHeight {
        case 480:
            
            self.introText.font = UIFont(name: "Lato", size: 14)
            self.shareText.font = UIFont(name: "Lato", size: 12)
            self.commentTite.font = UIFont(name: "Lato", size: 12)
            self.shareText.font = UIFont(name: "Lato", size: 12)
            self.giveScore.font = UIFont(name: "Lato", size: 12)
            
        
        default: // rest of screen sizes
            break
        }
        
        
        
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
            
            if self.state == false {
                self.saveData(self.currentObjectReview)
            }else{
                self.updateData(self.currentObjectReview)
            }
            
            
            if self.shareFacebook.on{
                
                
                let query = PFQuery(className:"Review")
                query.whereKey("user", equalTo:self.user!)
                query.whereKey("beer", equalTo:self.currentObjectReview!)
                
                if self.currentObjectReview!.objectForKey("Photo") != nil{
                    
                    let imageFile = self.currentObjectReview!.objectForKey("Photo") as! PFFile
                    ImageDAO.getImageFromParse(imageFile, ch: { (image, success) -> Void in
                        
                        if success{
                            
                            
                            let content:FBSDKShareLinkContent = FBSDKShareLinkContent()
                            
                            content.contentURL = NSURL(string: "http://www.beerlove.wix.com/commingsoon")
                            content.contentTitle = self.currentObjectReview!.objectForKey("name") as? String
                            content.contentDescription = self.currentObjectReview!.objectForKey("brewName") as? String
                            content.imageURL = NSURL(string: "http://files.parsetfss.com/f0fa3f24-4ced-49ca-bfaf-47bfe806aa21/tfss-ae855a52-5476-4594-99e0-69a4f5bc20fe-beer_love_2_1301%20copy%202.png")
                            
                            let shareDialog : FBSDKShareDialog = FBSDKShareDialog()
                            //shareDialog.mode = FBSDKShareDialogMode.Automatic
                            shareDialog.shareContent = content
                            shareDialog.show()
                            
                        }else{
                            //carregar imagem qualquer
                        }
                    })
                    
                }else{
                    print("sem imagem")
                    
                }
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
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.textFieldHeightSize =  textField.frame.origin.y
        //var x = textField.frame.origin.x;
        //NSLog("x Position is :%f , y position is : %f",x,y);
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
    
//MARK: - KEYBOARDS METHODS
extension ReviewVC{
        
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func keyboardWillHide(sender: NSNotification) {
        //let userInfo: [NSObject : AnyObject] = sender.userInfo!
        //let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
        self.view.frame.origin.y = 0
        //keyboardSize.height
    }
    func keyboardWillShow(sender: NSNotification) {
        let userInfo: [NSObject : AnyObject] = sender.userInfo!
        
        let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
        let offset: CGSize = userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue.size
        
        
        let bounds = UIScreen.mainScreen().bounds
        let width = bounds.size.width
        let height = bounds.size.height
        
        if (height - keyboardSize.height) <= self.textFieldHeightSize {
            
            if keyboardSize.height == offset.height {
                if self.view.frame.origin.y == 0 {
                    UIView.animateWithDuration(0.1, animations: { () -> Void in
                        self.view.frame.origin.y -= keyboardSize.height - 60
                    })
                }
            } else {
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.view.frame.origin.y = keyboardSize.height - offset.height - 60
                })
            }
            print(self.view.frame.origin.y)        }
    }
}

   