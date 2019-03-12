//

//  ReviewVC.swift

//  BeerLove

//

//  Created by Fernando H M Bastos on 12/3/15.

//  Copyright © 2015 Fernando H M Bastos. All rights reserved.

//



import UIKit

import Foundation




class ReviewVC: UIViewController {
    
//    @IBOutlet weak var sliderControl: UISlider!
//    
//    @IBOutlet var floatRatingView: FloatRatingView!
//    
//    @IBOutlet var updatedLabel: UILabel!
//    
//    @IBOutlet weak var commentText: UITextField!
//    
//    @IBOutlet weak var shareFacebook: UISwitch!
//    
//    @IBOutlet weak var giveScore: UILabel!
//    
//    @IBOutlet weak var commentTite: UILabel!
//    
//    @IBOutlet weak var introText: UILabel!
//    
//    @IBOutlet weak var shareText: UILabel!
//    
//    var beer : [Beer]! = [Beer]()
//    
//    var user = User()
//    
//    var currentObjectReview: PFObject?
//    
//    var reviewObject = PFObject(className:"Review")
//    
//    var textFieldHeightSize = 0.0 as CGFloat
//    
//    
//    
//    
//    //    let actionSheet = UIAlertController(title: "Teste", message: "My custom Share", preferredStyle: UIAlertControllerStyle.ActionSheet)
//    
//    
//    
//    var state = false
//    
//    
//    
//    
//    
//    override func viewDidLoad() {
//        
//        super.viewDidLoad()
//        
//        self.tintBarUp(view: self.view)
//        
//        self.navigationController?.navigationBar.barTintColor = UIColor(red: 250.0/255.0, green: 170.0/255.0, blue: 0.0/255.0, alpha: 1.0)
//        
//        self.navigationController?.navigationBar.tintColor = UIColor.white
//        
//     
//        let screenHeight = UIScreen.main.bounds.height
//        print(screenHeight)
//        
//        switch screenHeight {
//        case 480:
//            
//            self.introText.font = UIFont(name: "Lato", size: 14)
//            self.shareText.font = UIFont(name: "Lato", size: 12)
//            self.commentTite.font = UIFont(name: "Lato", size: 12)
//            self.shareText.font = UIFont(name: "Lato", size: 12)
//            self.giveScore.font = UIFont(name: "Lato", size: 12)
//            
//        
//        default: // rest of screen sizes
//            break
//        }
//        
//        
//        
//        NotificationCenter.default.addObserver(self, selector: Selector(("keyboardWillShow:")), name:UIResponder.keyboardWillShowNotification, object: self.view.window)
//        
//        NotificationCenter.default.addObserver(self, selector: Selector(("keyboardWillHide:")), name:UIResponder.keyboardWillHideNotification, object: self.view.window)
//    }
//    
//    
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
////        NotificationCenter.defaultCenter.removeObserver(self, name: UIKeyboardWillShowNotification, object: self.view.window)
////        NotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: self.view.window)
//    }
//    
//    
//    
//    
//    
//    @IBAction func saveReview(sender: AnyObject) {
//        
//        
////
////        let alert = UIAlertController(title: "Save Review?", message: "Beer Love", preferredStyle: UIAlertController.Style.alert)
////        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.Default, handler: { (action) -> Void in
////
////            if self.state == false {
////                self.saveData(self.currentObjectReview)
////            }else{
////                self.updateData(self.currentObjectReview)
////            }
////
////
////            if self.shareFacebook.on{
////
////
////                let query = PFQuery(className:"Review")
////                query.whereKey("user", equalTo:self.user!)
////                query.whereKey("beer", equalTo:self.currentObjectReview!)
////
////                if self.currentObjectReview!.objectForKey("Photo") != nil{
////
////                    let imageFile = self.currentObjectReview!.objectForKey("Photo") as! PFFile
////                    ImageDAO.getImageFromParse(imageFile, ch: { (image, success) -> Void in
////
////                        if success{
////
////
////                            let content:FBSDKShareLinkContent = FBSDKShareLinkContent()
////                            let title = self.currentObjectReview!.objectForKey("name") as! String
////                            let cervejaria = self.currentObjectReview!.objectForKey("brewName") as! String
////                            let user = User.currentUser()?.objectForKey("name") as! String
////                            let rate = String(self.reviewObject["rating"] as! Float)
////
////
////                            content.contentURL = NSURL(string: "http://www.beerlove.wix.com/commingsoon")
////                            content.contentTitle = "\(title)"
////
////                            content.contentDescription = "\(user) deu nota \(rate) para a cerveja \(title) da cervejaria \(cervejaria)"
////
////
////                                self.currentObjectReview!.objectForKey("brewName") as? String
////
////
////
////                            content.imageURL = NSURL(string: "http://files.parsetfss.com/f0fa3f24-4ced-49ca-bfaf-47bfe806aa21/tfss-c70052c9-f85d-4d8b-ae28-f0ee4d6ed5b8-beer_love_2_1301%20copy500.png")
////
////                            let shareDialog : FBSDKShareDialog = FBSDKShareDialog()
////                            shareDialog.mode = FBSDKShareDialogMode.Automatic
////                            shareDialog.shareContent = content
////                            shareDialog.show()
////
////                        }else{
////                            //carregar imagem qualquer
////                        }
////                    })
////
////                }else{
////                    print("sem imagem")
////
////                }
////            }
////
////            self.navigationController?.popViewControllerAnimated(true)
////        }))
////        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.Cancel, handler: nil))
////        self.present(alert, animated: true, completion: nil)
////
////
//    }
//    
//    @IBAction func sliderControl(sender: UISlider) {
//        let currentValue = roundf(sender.value / 0.2) * 0.25
//        updatedLabel.text = String(format: "%.2f", currentValue)
//        self.floatRatingView.rating = Float(currentValue)
//    }
//    
//
//    func findReview (review: PFObject?) -> Bool {
////        let query = PFQuery(className:"Review")
////        query.whereKey("user", equalTo:user)
////        query.whereKey("beer", equalTo:review)
////
////        self.state = false
////
////        query.findObjectsInBackgroundWithBlock {
////
////            (objects: [PFObject]?, error: NSError?) -> Void in
////
////            if error == nil {
////
////                // The find succeeded.
////                print("Successfully retrieved \(objects!.count) scores.")
////
////                if objects!.count > 0 {
////
////                    self.reviewObject = objects![0]
////                    self.commentText.text = self.reviewObject["comment"] as? String
////                    self.floatRatingView.rating = (self.reviewObject["rating"] as? Float)!
////                    self.sliderControl.value = (self.reviewObject["rating"] as? Float)!
////                    self.updatedLabel.text = String(self.reviewObject["rating"])
////                    self.state = true
////                    print(self.state)
////
////                }
//////            }
////        }
////
////        return state
//    }
//    
//    //
//    
//
//    // update informations
//    
////    func saveData(beer: PFObject?){
////        reviewObject["user"] = user
////        reviewObject["beer"] = currentObjectReview
////        reviewObject["rating"] = Double(updatedLabel.text!)
////        reviewObject["comment"] = commentText.text
////        reviewObject.saveInBackgroundWithBlock {
////
////            (success: Bool, error: NSError?) -> Void in
////            if (success) {
////                // The object has been saved.
////                self.state = true
////            }else{
////                print("Erro ao salvar dados")
////            }
////        }
////    }
//    
//    
//    func textFieldDidBeginEditing(textField: UITextField) {
//        self.textFieldHeightSize =  textField.frame.origin.y
//        //var x = textField.frame.origin.x;
//        //NSLog("x Position is :%f , y position is : %f",x,y);
//    }
//
//    
//    // update informations
//    func updateData(review: PFObject?){
//        reviewObject["user"] = self.user
//        reviewObject["beer"] = self.currentObjectReview
//        reviewObject["rating"] = Double(self.updatedLabel.text!)
//        reviewObject["comment"] = self.commentText.text
//        reviewObject.saveInBackground()
//    }
//
//}
//    
////MARK: - KEYBOARDS METHODS
//extension ReviewVC{
////
////    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
////        self.view.endEditing(true)
//    }
//    
//    
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        self.view.endEditing(true)
//        return true
//    }
//    
//    func keyboardWillHide(sender: NSNotification) {
//        //let userInfo: [NSObject : AnyObject] = sender.userInfo!
//        //let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
//        self.view.frame.origin.y = 0
//        //keyboardSize.height
//    }
//    func keyboardWillShow(sender: NSNotification) {
////        let userInfo: [NSObject : AnyObject] = sender.userInfo!
////
////        let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
////        let offset: CGSize = userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue.size
////
////
////        let bounds = UIScreen.mainScreen().bounds
////        let width = bounds.size.width
////        let height = bounds.size.height
////
////        if (height - keyboardSize.height) <= self.textFieldHeightSize {
////
////            if keyboardSize.height == offset.height {
////                if self.view.frame.origin.y == 0 {
////                    UIView.animateWithDuration(0.1, animations: { () -> Void in
////                        self.view.frame.origin.y -= keyboardSize.height - 60
////                    })
////                }
////            } else {
////                UIView.animateWithDuration(0.1, animations: { () -> Void in
////                    self.view.frame.origin.y = keyboardSize.height - offset.height - 60
////                })
////            }
////            print(self.view.frame.origin.y)        }
//    }
//
//
}
