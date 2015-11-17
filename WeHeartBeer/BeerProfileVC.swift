//
//  BeerProfileVC.swift
//  WeHeartBeer
//
//  Created by Júlio César Garavelli on 05/11/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import UIKit

class BeerProfileVC: UIViewController, FloatRatingViewDelegate {
    
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
    var currentObject: PFObject?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(currentObject)

        /** Note: With the exception of contentMode, all of these
        properties can be set directly in Interface builder **/
        
        // Required float rating view params
        self.floatRatingView.emptyImage = UIImage(named: "hops")
        self.floatRatingView.fullImage = UIImage(named: "hopsGreen")
        // Optional params
        self.floatRatingView.delegate = self
        self.floatRatingView.contentMode = UIViewContentMode.ScaleAspectFit
        self.floatRatingView.maxRating = 5
        self.floatRatingView.minRating = 0
        self.floatRatingView.rating = 2.5
        self.floatRatingView.editable = true
        self.floatRatingView.halfRatings = true
        self.floatRatingView.floatRatings = false
        
        // Segmented control init
        //self.ratingSegmentedControl.selectedSegmentIndex = 1
        
        // Labels init
        //        self.liveLabel.text = NSString(format: "%.2f", self.floatRatingView.rating) as String
        //self.updatedLabel.text = NSString(format: "%.2f", self.floatRatingView.rating) as String
    }
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    
        
        //Pointer for view beer name
        let pointerReceive = "cervejum"

        BeerServices.findBeerName(pointerReceive) { (beer, success) -> Void in

            if success {
                self.beer = beer
                
                //Printing beer name
                print(self.beer[0])
                
                //Self name for view
                //self.name.text! = self.beer[0].objectForKey("name") as! String!
                self.updateData(self.beer[0])
            }else{
                //Warning error
                print("Erro, cerveja não encontrada!")
            }
        }
    }
    
    // update informations
    func updateData(beer: Beer){
        
        print(beer)
        
        self.name.text = beer.objectForKey("name") as? String
//        //self.brewery.text! = beer.objectForKey("brewery") as! String
//        self.style.text = beer.objectForKey("Style") as? String
//        //self.ibv.text! = beer.objectForKey("IBV") as! String!
        
//        self.pffileToUIImage(beer)
   
   //pegando a foto do parse
        let userImageFile = beer.objectForKey("Photo") as! PFFile
        userImageFile.getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    self.photo.image = image 
                }
            }
        }
        
        //self.photo.image = beer.objectForKey("Photo") as? UIImage
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ratingTypeChanged(sender: UISegmentedControl) {
        self.floatRatingView.halfRatings = sender.selectedSegmentIndex==1
        self.floatRatingView.floatRatings = sender.selectedSegmentIndex==2
    }
    
    // MARK: FloatRatingViewDelegate
    
    func floatRatingView(ratingView: FloatRatingView, isUpdating rating:Float) {
        self.liveLabel.text = NSString(format: "%.2f", self.floatRatingView.rating) as String
    }
    
    func floatRatingView(ratingView: FloatRatingView, didUpdate rating: Float) {
        self.updatedLabel.text = NSString(format: "%.2f", self.floatRatingView.rating) as String
    }
    
    
    func pffileToUIImage(beer:Beer)->UIImage{
        let userPicture = beer.objectForKey("Photo")
        
        return userPicture as! UIImage
    }
    
    
}


