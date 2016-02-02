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
    @IBOutlet var userTrophiesLink: UIImageView!
    @IBOutlet var userFriendsLink: UIImageView!
    @IBOutlet var userPlacesLink: UIImageView!
    
    
    let layer:CGFloat = 7
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if UserServices.loggedUser() == false{
            performSegueWithIdentifier("segueFacebookCheckin", sender: nil)
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
            if UserServices.loggedUser(){
            self.navigationItem.hidesBackButton =  true
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 250.0/255.0, green: 170.0/255.0, blue: 0.0/255.0, alpha: 1.0)
            self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()

            
            print("deu certo userprofile")
                  //  getFBAppFriends(nil, failureHandler: {(error)
                   //     in print(error)});
                    

            self.updateData()
            let tapGesture1 = UITapGestureRecognizer(target: self, action: Selector("beersTapped:"))
            let tapGesture2 = UITapGestureRecognizer(target: self, action: Selector("imageTapped:"))
            let tapGesture3 = UITapGestureRecognizer(target: self, action: Selector("imageTapped:"))
            let tapGesture4 = UITapGestureRecognizer(target: self, action: Selector("friendsTapped:"))
            self.userBeerLink.userInteractionEnabled = true
            self.userBeerLink.addGestureRecognizer(tapGesture1)
            self.userTrophiesLink.userInteractionEnabled = true
            self.userTrophiesLink.addGestureRecognizer(tapGesture2)
            self.userFriendsLink.userInteractionEnabled = true
            self.userFriendsLink.addGestureRecognizer(tapGesture3)
            self.userPlacesLink.userInteractionEnabled  = true
            self.userPlacesLink.addGestureRecognizer(tapGesture4)
        }else{
            performSegueWithIdentifier("segueFacebookCheckin", sender: nil)
        }
    }

    
    func beersTapped(img:AnyObject){
        self.performSegueWithIdentifier("segueUserBeers", sender: nil)
    }
    
    
    func imageTapped(img:AnyObject){
        self.performSegueWithIdentifier("underConstruction", sender: nil)
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



