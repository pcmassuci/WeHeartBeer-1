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
    

    @IBOutlet var ratingSegmentedControl: UISegmentedControl!
    @IBOutlet var floatRatingView: FloatRatingView!
    @IBOutlet var liveLabel: UILabel!
    @IBOutlet var updatedLabel: UILabel!
    
    @IBOutlet var name: UILabel!
    @IBOutlet var brewery: UILabel!
    @IBOutlet var style: UILabel!
    @IBOutlet var ibv: UILabel!
    @IBOutlet var photo: UIImageView!
    
    
    
    var beer : [Beer]! = [Beer]()
    var user = PFUser.currentUser()
    var currentObject: PFObject?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(currentObject)
        self.updateData(currentObject)
        
        self.navigationController?.navigationBar.hidden = false
        
      
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        let stack = self.navigationController?.viewControllers
        let target = stack![0]
        self.navigationController?.popToViewController(target, animated: true)
      
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
       
    }
   
    
    // update informations
    func updateData(beer: PFObject?){
        
        
           self.name.text = beer!.objectForKey("name") as? String

        
        
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    @IBAction func saveRating(sender: AnyObject) {
        

        performSegueWithIdentifier("segueReview", sender: currentObject)
        
    }
    
    
    
    
    // update informations
    func saveData(beer: PFObject?){

        
        let beerReview = PFObject(className:"Review")
       
        beerReview["user"] = user
        beerReview["beer"] = beer
        beerReview["rating"] = Double(liveLabel.text!)
        beerReview["comment"] = commentText.text
        beerReview.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                print("deu")
            } else {
                // There was a problem, check error.description
            }
        }
        

        
    }
    
    
    
    
    
    @IBAction func breweryButton(sender: AnyObject) {
        //não serve para nada
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //print(currentObject?.objectForKey("brewery")?.objectId)
        
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
                destination.currentObjectReview = sender as? PFObject
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


