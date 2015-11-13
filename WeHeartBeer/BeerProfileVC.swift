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
    @IBOutlet var brewery: FloatRatingView!
    @IBOutlet var IBU: UILabel!
    @IBOutlet var Photo: UIImageView!
    
    
    
    var beer : [Beer]! = [Beer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        self.liveLabel.text = NSString(format: "%.2f", self.floatRatingView.rating) as String
        self.updatedLabel.text = NSString(format: "%.2f", self.floatRatingView.rating) as String
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        
        
        var pointerReceive = "cervejum"
        
      
        BeerServices.findBeerName(pointerReceive) { (beer, success) -> Void in
    
       
            if success {
                
                self.beer = beer

                
                
                print(self.beer[0])
                //self.updateData(self.brewery[0])
                
                
            }else{
                //colocar aviso de erro para o usuário
            }
        }

    
        // update informations
        func updateData(beer: Beer){
            
            
            name.text = beer.objectForKey("name") as? String
            //Brewery.text = beer.objectForKey("Brewery") as? String
           // .text = beer.objectForKey("Style") as? String
            IBU.text = beer.objectForKey("IBU") as? String
            Photo.image = beer.objectForKey("Photo") as? UIImage
        }
        
        
        
        
        
        
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
    
}
