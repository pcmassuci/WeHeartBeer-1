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
    @IBOutlet var ibv: UILabel!
    @IBOutlet var photo: UIImageView!
    //@IBOutlet weak var brewButton: UIButton!
    
    
    
    var beer : [Beer]! = [Beer]()
    var user = PFUser.currentUser()
    var currentObject: PFObject?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(currentObject)
        self.updateData(currentObject)
        
        self.navigationController?.navigationBar.hidden = false
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "labelAction:")
        self.brewery.addGestureRecognizer(tap)
      //  tap.delegate = self

    }
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Check if user is logged in
        if UserServices.loggedUser() {
            self.ratingButton.hidden = false
        }else{
            self.ratingButton.hidden = true
        }
        
           }
    
    // update informations
    func updateData(beer: PFObject?){
        print(beer?.objectForKey("brewery")?.objectId)
        self.name.text = beer!.objectForKey("name") as? String
        self.brewery.text = beer!.objectForKey("brewName") as? String
        
      
        

        
        // pegando a foto do parse
        
        if beer!.objectForKey("Photo") != nil{
            let userImageFile = beer!.objectForKey("Photo") as! PFFile
            
            userImageFile.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        let image = UIImage(data:imageData)
                        self.photo.image = image
                    }else{
                        print("sem imagem")
                    }
                }
                
            }
        }else{
            print("erro na imagem")
        }
        
        
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
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if segue.identifier == "segueBeer"{
            if let destination = segue.destinationViewController  as? BreweryVC{
               
                destination.delegate = self

                _ = self.currentObject?.objectForKey("brewery")?.objectID
                
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


