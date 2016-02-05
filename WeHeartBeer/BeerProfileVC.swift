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
    
    @IBOutlet weak var reviewsTable: UITableView!
    @IBOutlet weak var reviewsImg: UIImageView!
    @IBOutlet weak var reviewsLabel: UILabel!
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
    
    //copiado d frango
    @IBOutlet weak var listOfBeers: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var reviews: [PFObject]? = [PFObject]?()
    var beers: [Beer]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(self.currentObject)
       
        if self.currentObject != nil{
            getRantingAndReviews(self.currentObject!)
        }
        
        let screenHeight = UIScreen.mainScreen().bounds.height
        print(screenHeight)
        
        switch screenHeight {
        case 480:
            
            self.reviewsImg.hidden = true
            self.reviewsLabel.hidden = true
            self.reviewsTable.hidden = true
            
            
        default: // rest of screen sizes
            break
        }
        
        self.navigationController?.navigationBar.hidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 250.0/255.0, green: 170.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        
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
        self.navigationController?.setNavigationBarHidden(false, animated: true)

        self.navigationController?.navigationBar.hidden = false

       // navigationCollor()
        // Check if user is logged in
        
        self.updateData(self.currentObject)
        ReviewDAO.findReviewsFromBeer(self.currentObject) { (beer, success) -> Void in
            if success{
                for b in beer!{
                    self.reviews?.append(b)
                }
            }else{
                //tratar erro
            }
        }
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

extension BeerProfileVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label: UILabel = UILabel()
        label.text = "Cervejas"
        label.textColor = UIColor.blackColor()
        label.backgroundColor = UIColor(red: 255.0/255.0, green: 192.0/255.0, blue: 3.0/255.0, alpha: 1.0)
        
        return label
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.beers.count
    }
    
    // Number of sections in tableview - not used
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    //Sets the tableview cell and change its info to the correspondent object
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = listOfBeers.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ReviewVCCell
        
        
        
        
        if self.beers[indexPath.row].objectForKey("Photo") != nil{
            let imageFile = self.beers[indexPath.row].objectForKey("Photo") as! PFFile
            ImageDAO.getImageFromParse(imageFile, ch: { (image, success) -> Void in
                if success{
                    cell.imageBeersFromUser.image = image
                    
                }else{
                    print("sem imagem")
                    cell.imageBeersFromUser.image = nil
                    
                }
            })
            
        }else{
            print("erro na imagem")
            cell.imageBeersFromUser.image = nil
        }
        
        
        cell.beersFromUser?.text = self.beers[indexPath.row].objectForKey("name") as? String
        cell.breweryFromUser?.text = self.beers[indexPath.row].objectForKey("brewName") as? String
        
        if let rating = self.reviews![indexPath.row].valueForKey("rating") {
            cell.ratingFromUser?.text = "\(rating)"
        } else {
            cell.ratingFromUser?.text = "No rating available"
        }
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row < self.beers.count {
            performSegueWithIdentifier("segueBeerReviewToBeer", sender: indexPath)
        }
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "segueBeerReviewToBeer" {
//            let destination = segue.destinationViewController as! BeerProfileVC
//            let indexPath = sender as! NSIndexPath
//            let review = self.reviews[indexPath.row]
//            let beer = self.beers[indexPath.row]
//            
//            destination.idReview = review
//            destination.currentObject = beer
//        }
//    }
}
// MARK:- get ratting and Review
extension BeerProfileVC{
    
    private func getRantingAndReviews(beer:PFObject){
        ReviewDAO.findReviewAndRating(beer) { (reviews, rate, success) -> Void in
            if success{
                print("salvar array e preencher tabela")
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


