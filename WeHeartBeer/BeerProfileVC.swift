//
//  BeerProfileVC.swift
//  WeHeartBeer
//
//  Created by Júlio César Garavelli on 05/11/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import UIKit
import Foundation
import Parse
import ParseFacebookUtilsV4

class BeerProfileVC: UIViewController {
    
//    FloatRatingViewDelegate
    
    @IBOutlet weak var saveBeerProfile: UIButton!

    @IBOutlet weak var commentText: UITextField!
    
    @IBOutlet weak var ratingButton: UIButton!
    @IBOutlet var liveLabel: UILabel!
    @IBOutlet var updatedLabel: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var brewery: UILabel!
    @IBOutlet var style: UILabel!
    @IBOutlet var ibv: UILabel! //needs renaming
    @IBOutlet var photo: UIImageView!
    @IBOutlet weak var brewButton: UIButton!
    var idReview:Review!
      
    

  //  var beer : [Beer]! = [Beer]()
    var user = PFUser.currentUser()
    var currentObject: PFObject?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(currentObject)
        self.updateData(currentObject)
        
        print("REVIEW SELECIONADA \(self.idReview) \n\n")
        
        
        
        self.navigationController?.navigationBar.hidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 250.0/255.0, green: 170.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        
        
        brewButton.titleLabel?.numberOfLines = 0
        brewButton.titleLabel?.preferredMaxLayoutWidth = 250
        brewButton.titleLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        brewButton.titleLabel?.sizeToFit()
        
        photo.layer.borderWidth = 1
        photo.layer.masksToBounds = false
        photo.layer.borderColor = UIColor.blackColor().CGColor
        photo.clipsToBounds = true

        
        

    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
       // navigationCollor()
        // Check if user is logged in
        if UserServices.loggedUser() {
            self.ratingButton.hidden = false
        }else{
            self.ratingButton.hidden = true
        }
        
           }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        photo.layer.cornerRadius = photo.frame.height/2
        
    }
    
    // update informations
    func updateData(beer: PFObject?){
        print(beer?.objectForKey("brewery")?.objectId)
        self.name.text = beer!.objectForKey("name") as? String
        self.style.text = beer!.objectForKey("Style") as? String
        
        let abv = beer!.objectForKey("ABV") as! String
        self.ibv.text = "\(abv)%"
        
        
        let nameOfBrew = beer!.objectForKey("brewName") as? String
        self.brewButton.setTitle(nameOfBrew, forState: UIControlState.Normal)
      
        

        
        // pegando a foto do parse
        let beerImage = beer!.objectForKey("Photo") as? PFFile
        if beerImage != nil{
            ImageDAO.getImageFromParse(beerImage, ch: { (image, success) -> Void in
                if success{
                    if image != nil {
                         self.photo.image = image
                        
                    }else{
                        print("Nao tem imagem")
                        // não tem imagem
                    }
                    
                }else{
                    //erro ao obter imagem
                }
            })
        }else{
            print("imagem generica")
        }
        
//        if beer!.objectForKey("Photo") != nil{
//            let userImageFile = beer!.objectForKey("Photo") as! PFFile
//            
//            userImageFile.getDataInBackgroundWithBlock {
//                (imageData: NSData?, error: NSError?) -> Void in
//                if error == nil {
//                    if let imageData = imageData {
//                        let image = UIImage(data:imageData)
//                        self.photo.image = image
//                    }else{
//                        print("sem imagem")
//                    }
//                }
//                
//            }
//        }else{
//            print("erro na imagem")
//        }
//        
//        
    }
    
    @IBAction func callBrewery(sender: AnyObject) {
        performSegueWithIdentifier("segueBeer", sender: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func reviewButton(sender: AnyObject) {
        self.performSegueWithIdentifier("segueReview", sender: nil)
    }
    
    
    // Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if segue.identifier == "segueBeer"{
            if let destination = segue.destinationViewController  as? BreweryVC{
               
                destination.delegate = self

//                _ = self.currentObject?.objectForKey("brewery")?.objectID
                
                print(self.currentObject?.objectForKey("brewery"))
                
                destination.currentBrewery = self.currentObject?.objectForKey("brewery") as? PFObject
            }
        }
        if segue.identifier == "segueReview"{
            if let destination = segue.destinationViewController as? ReviewVC {
                destination.currentObjectReview = (currentObject as? PFObject?)!
            }
            }
    }
    
}


extension BeerProfileVC: BreweryVCDelegate{
    func newBeer(objIDbeer:PFObject?) {
        self.currentObject = objIDbeer
        print("passou o dado")
        print(self.currentObject)
        self.updateData(objIDbeer)
    }
    
    
}


