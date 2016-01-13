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
        
//        
//       // let parameters = ["fields": "id,birthday,location,locale,hometown,gender, name, picture.type(large), email,friends"]
//        let paramen = ["fields": "id,me, friends"]
//        
//        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me",     parameters: paramen)
//        graphRequest.startWithCompletionHandler { (connection, result:AnyObject!, error) -> Void in
//            
//            
//            if ((error) != nil)
//            {
//                // Process error
//                print("Error: \(error)")
//            }
//            else
//            {
//                //get Facebook ID
//                let faceBookID: NSString = result.valueForKey("id") as! NSString
////                let userFriends = result.valueForKey("friends")
////                print(userFriends)
//                //get username
//                // let userName : NSString = result.valueForKey("name") as! NSString
//                //get facebook friends who use app
//                let friendlist = result.valueForKey("friends")! as! NSDictionary
////                print(friendlist)
////                print(faceBookID)
//                print(friendlist)
//            }
//            
//        }
//tentativa 2
              //  getFBTaggableFriends(nil, failureHandler: {(error)
           // in print(error)});
        
        
        if UserServices.loggedUser(){
            self.navigationController?.navigationBar.hidden = false
            self.navigationItem.hidesBackButton =  true
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 255.0/255.0, green: 192.0/255.0, blue: 3.0/255.0, alpha: 1.0)
            
            print("deu certo userprofile")
            getFBAppFriends(nil, failureHandler: {(error)
                in print(error)});
            
            
            self.updateData()
            let tapGesture1 = UITapGestureRecognizer(target: self, action: Selector("beersTapped:"))
            let tapGesture2 = UITapGestureRecognizer(target: self, action: Selector("imageTapped:"))
            let tapGesture3 = UITapGestureRecognizer(target: self, action: Selector("imageTapped:"))
            let tapGesture4 = UITapGestureRecognizer(target: self, action: Selector("imageTapped:"))
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
    
    
    // pegar amigos que usam o app
    func getFBAppFriends(nextCursor : String?, failureHandler: (error: NSError) -> Void) {
        
        let qry = "/me/friends"
        var parameters = Dictionary<String, String>() as? Dictionary
        if nextCursor == nil {
            parameters = nil
        } else {
            parameters!["after"] = nextCursor
        }
        
        var request = FBSDKGraphRequest(graphPath: qry, parameters: parameters);
        
        
        request.startWithCompletionHandler { (connection : FBSDKGraphRequestConnection!, result : AnyObject!, error : NSError!) -> Void in
            
            if (error) != nil{
                // Process error
                print("Error: \(error)")
                
            }else{
                //println("fetched user: \(result)")
                let resultdict = result as! NSDictionary
                let data : NSArray = resultdict.objectForKey("data") as! NSArray
                
                for i in 0..<data.count {
                    let valueDict : NSDictionary = data[i] as! NSDictionary
                    //                    let id = valueDict.objectForKey("id") as! String
                    let name = valueDict.objectForKey("name") as! String
                    //                    let pictureDict = valueDict.objectForKey("picture") as! NSDictionary
                    //                    let pictureData = pictureDict.objectForKey("data") as! NSDictionary
                    //                    let pictureURL = pictureData.objectForKey("url") as! String
                    print("Name: \(name)")
                    //println("ID: \(id)")
                    //println("URL: \(pictureURL)")
                }
                if let after = ((resultdict.objectForKey("paging") as? NSDictionary)?.objectForKey("cursors") as? NSDictionary)?.objectForKey("after") as? String {
                    self.getFBAppFriends(after, failureHandler: {(error) in
                        print("error")})
                } else {
                    print("Can't read next!!!")
                }
            }
            
        }
        
        
        //            if error == nil {
        //                var resultdict = result as! NSDictionary
        //                print("Result Dict: \(resultdict)")
        //                var data : NSArray = resultdict.objectForKey("data") as! NSArray
        //
        //                for i in 0..<data.count {
        //                    let valueDict : NSDictionary = data[i] as! NSDictionary
        //                    let id = valueDict.objectForKey("id") as! String
        //                    print("the id value is \(id)")
        //                }
        //
        //                if let after = ((resultdict.objectForKey("paging") as? NSDictionary)?.objectForKey("cursors") as? NSDictionary)?.objectForKey("after") as? String {
        //                    self.getFBAppFriends(after, failureHandler: {(error) in
        //                        print("error")})
        //                } else {
        //                    print("Can't read next!!!")
        //                }
        //
        //
        //
        //                var friends = resultdict.objectForKey("data") as! NSArray
        //                print("Found \(friends.count) friends")
        //
        //                print("Friends are : \(result)")
        //            } else {
        //                print("Error Getting Friends \(error)");
        //            }
        //        }
        
        
        
        
    }
    
    
    
    
    //pegar todos os amigos do face
    func getFBTaggableFriends(nextCursor : String?, failureHandler: (error: NSError) -> Void) {
        let qry : String = "me/taggable_friends"
        var parameters = Dictionary<String, String>() as? Dictionary
        if nextCursor == nil {
            parameters = nil
        } else {
            parameters!["after"] = nextCursor
        }
        // Facebook: get taggable friends with pictures
        var request = FBSDKGraphRequest(graphPath: qry, parameters: parameters)
        request.startWithCompletionHandler { (connection : FBSDKGraphRequestConnection!, result : AnyObject!, error : NSError!) -> Void in
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                //println("fetched user: \(result)")
                var resultdict = result as! NSDictionary
                var data : NSArray = resultdict.objectForKey("data") as! NSArray
                
                for i in 0..<data.count {
                    let valueDict : NSDictionary = data[i] as! NSDictionary
                    let id = valueDict.objectForKey("id") as! String
                    let name = valueDict.objectForKey("name") as! String
                    let pictureDict = valueDict.objectForKey("picture") as! NSDictionary
                    let pictureData = pictureDict.objectForKey("data") as! NSDictionary
                    let pictureURL = pictureData.objectForKey("url") as! String
                    print("Name: \(name)")
                    print("ID: \(id)")
                    //println("URL: \(pictureURL)")
                }
                if let after = ((resultdict.objectForKey("paging") as? NSDictionary)?.objectForKey("cursors") as? NSDictionary)?.objectForKey("after") as? String {
                    self.getFBTaggableFriends(after, failureHandler: {(error) in
                        print("error")})
                } else {
                    print("Can't read next!!!")
                }
            }
        }
        
    }
    
    
    func updateData(){
        let user = User.currentUser()
        self.displayName.text = user!.objectForKey("name") as? String
        
        if user!.objectForKey("photo") != nil{
            
            let userImageFile = user!.objectForKey("photo") as! PFFile
            
            userImageFile.getDataInBackgroundWithBlock {
                
                (imageData: NSData?, error: NSError?) -> Void in
                
                if error == nil {
                    if let imageData = imageData {
                        let image = UIImage(data:imageData)
                        self.displayPicture.image = image
                    }else{
                        print("sem imagem")
                    }
                }
            }
            
        }else{
            print("erro na imagem")
        }
    }
    
}



