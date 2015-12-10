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
    
    @IBOutlet weak var beerImage: UIImageView!
    
    //teste
    var dict : NSDictionary!
    //butons
    
    
    @IBOutlet weak var displayPicture: UIImageView!
    @IBOutlet weak var displayName: UILabel!
    

    

    let layer:CGFloat = 7
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserServices.loggedUser(){
                    self.navigationController?.navigationBar.hidden = false
                    self.navigationItem.hidesBackButton =  true
                    self.navigationController?.navigationBar.barTintColor = UIColor(red: 255.0/255.0, green: 192.0/255.0, blue: 3.0/255.0, alpha: 1.0)
            let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
            self.beerImage.userInteractionEnabled = true
            self.beerImage.addGestureRecognizer(tapGestureRecognizer)

              print("deu certo userprofile")
                    
                        self.updateData()
                   
                }else{
              
                    print("deu errado userprofile")
//                    self.tabBarController?.selectedIndex = 0
                }
        
        
        //}
       
    }
    
    
    
    func imageTapped(img: AnyObject)
    {
        //  print(self.beer)
        self.performSegueWithIdentifier("userBeers", sender: nil)
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

