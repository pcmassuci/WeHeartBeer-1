//
//  UserProfileVC.swift
//  WeHeartBeer
//
//  Created by Matheus Santos Lopes on 06/11/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import UIKit
import Foundation
import Parse
import ParseFacebookUtilsV4

class UserProfileVC: UIViewController {
    
    var dict : NSDictionary!
    
    @IBOutlet weak var displayPicture: UIImageView!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet var userBeerLink: UIImageView!
    @IBOutlet var userFriendsLink: UIImageView!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var beerLabel: UILabel!
    @IBOutlet weak var friendsLabel: UILabel!
    @IBOutlet weak var beerNumber: UILabel!
    @IBOutlet weak var friendsNumber: UILabel!
    
    
    let layer:CGFloat = 7
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if UserServices.loggedUser() == false{
           // performSegueWithIdentifier("segueFacebookCheckin", sender: nil)
        }
        self.tintBarUp(self.view)
        displayPicture.layer.borderWidth = 1
        displayPicture.layer.masksToBounds = false
        displayPicture.layer.borderColor = UIColor.blackColor().CGColor
        displayPicture.clipsToBounds = true
        
        displayPicture.layer.cornerRadius = displayPicture.frame.height/2
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        

            if UserServices.loggedUser(){
            self.checkBeers()
            self.checkFriends()
                
            self.navigationItem.hidesBackButton =  true
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 250.0/255.0, green: 170.0/255.0, blue: 0.0/255.0, alpha: 1.0)
            self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
            self.navigationController?.navigationBar.hidden = true
                
            print("deu certo userprofile")
                  //  getFBAppFriends(nil, failureHandler: {(error)
                   //     in print(error)});
            let screenHeight = UIScreen.mainScreen().bounds.height
                print(screenHeight)
                
            switch screenHeight {
                
            case 480:
                    
                self.displayName.font = UIFont(name: "Lato-Heavy", size: 18)
                self.beerLabel.font = UIFont(name: "Lato-Heavy", size: 16)
                self.friendsLabel.font = UIFont(name: "Lato-Heavy", size: 16)
                self.beerNumber.font = UIFont(name: "Lato-Heavy", size: 20)
                self.friendsNumber.font = UIFont(name: "Lato-Heavy", size: 20)

                
            case 568:
                self.beerNumber.font = UIFont(name: "Lato-Heavy", size: 28)
                self.friendsNumber.font = UIFont(name: "Lato-Heavy", size: 28)
                
            default: // rest of screen sizes
                break
            }


            self.updateData()
            let tapGesture1 = UITapGestureRecognizer(target: self, action: Selector("beersTapped:"))

            let tapGesture2 = UITapGestureRecognizer(target: self, action: Selector("friendsTapped:"))
            self.userBeerLink.userInteractionEnabled = true
            self.userBeerLink.addGestureRecognizer(tapGesture1)
            self.userFriendsLink.userInteractionEnabled  = true
            self.userFriendsLink.addGestureRecognizer(tapGesture2)
        }else{
           // performSegueWithIdentifier("segueFacebookCheckin", sender: nil)
        }
    }

    
    func beersTapped(img:AnyObject){
        self.performSegueWithIdentifier("segueUserBeers", sender: nil)
    }
    
    func friendsTapped(img:AnyObject){
        self.performSegueWithIdentifier("segueUserFriends", sender: nil)
    }
    
       
    func updateData(){
        let user = User.currentUser()
        self.displayName.text = user!.objectForKey("name") as? String
        let pffile = user!.objectForKey("photo") as! PFFile
        
        ImageDAO.getImageFromParse(pffile) { (image, success) -> Void in
            if success{
                if image != nil{
                     self.displayPicture.image = image
                    
                }else{
                    //user without Image
                }
            }else{
                // error to get image
            }
            
        }
    }
    
}


extension UserProfileVC{
    
    
    func checkBeers(){
        
        ReviewServices.findReviewfromUser(User.currentUser()!) { (reviews, success) -> Void in
            
            self.beerNumber.text = String((reviews?.count)! as NSNumber)
        }
    }
    
    
    func checkFriends(){
        FriendsDAO.queryFriends { (requests, waitingFriends, myFriends, success) -> Void in
            if success{
                
                if myFriends != nil {
                    self.friendsNumber.text = "\(myFriends!.count)"
                } else {
                    self.friendsNumber.text = "0"
                }
            } else{
                //naoDeuCerto
            }
        }
    }

}


