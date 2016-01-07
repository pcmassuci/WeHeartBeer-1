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
    
    
    //teste
    var dict : NSDictionary!
    //butons
    
    
    @IBOutlet weak var displayPicture: UIImageView!
    @IBOutlet weak var displayName: UILabel!
    
    @IBOutlet var userBeerLink: UIImageView!
    @IBOutlet var userTrophiesLink: UIImageView!
    @IBOutlet var userFriendsLink: UIImageView!
    @IBOutlet var userPlacesLink: UIImageView!
    

    let layer:CGFloat = 7
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserServices.loggedUser(){
                    self.navigationController?.navigationBar.hidden = false
                    self.navigationItem.hidesBackButton =  true
                    self.navigationController?.navigationBar.barTintColor = UIColor(red: 255.0/255.0, green: 192.0/255.0, blue: 3.0/255.0, alpha: 1.0)
            
              print("deu certo userprofile")
                    
                        self.updateData()
            let tapGesture1 = UITapGestureRecognizer(target: self, action: Selector("imageTapped:"))
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
            
                    print("deu errado userprofile")
//                    self.tabBarController?.selectedIndex = 0
                }
        
        
        //}
       
    }
  
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let parameters = ["fields": "id,birthday,location,locale,hometown,gender, name, picture.type(large), email"]
      
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me",     parameters: parameters)
        graphRequest.startWithCompletionHandler { (connection, result:AnyObject!, error) -> Void in
            
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                //get Facebook ID
                let faceBookID: NSString = result.valueForKey("id") as! NSString
                //get username
               // let userName : NSString = result.valueForKey("name") as! NSString
                //get facebook friends who use app
               // let friendlist: AnyObject = (result.valueForKey("friends")! as AnyObject)
                print(faceBookID)
                //print(friendlist)
            }

    }
    }
    
    func imageTapped(img:AnyObject){
        self.performSegueWithIdentifier("underConstruction", sender: nil)
    }
    
    
//    @IBAction func loginButton(sender: AnyObject) {
//
//        
//        
//        UserServices.loginFaceUser { (success) -> Void in
//            if success{
//                print("Deu Certo Atualizar tela!")
//                self.updateData()
//                self.loginButton.hidden = true
//                
//                
//            }else{
//                print("Usuário não encontrado")
//            }
//            
//            
//        }
//        
//    }
    
    
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

