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
    @IBOutlet weak var ibuLabel: UILabel!
    @IBOutlet weak var rateUser: UILabel!
    
    var idReview:Review!
    
    
    // fernado ligar esse aqui meu filho
    @IBOutlet var rateLabel: UILabel!
    

  //  var beer : [Beer]! = [Beer]()
    var user = PFUser.currentUser()
    var currentObject: PFObject?
    
    //copiado d frango
    @IBOutlet weak var listOfBeers: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var rev:[PFObject]? = [PFObject]()
    var beers: [Beer]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listOfBeers.dataSource = self
        
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
        
                
        self.tintBarUp(self.view)
        

    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if self.internetCheck() {
        }else{
           self.alert("Atenção", message: "Verifique sua conexão com a internet", option: false, action: nil)
        }
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.hidden = false

        
        // Check if user is logged in
        self.rev?.removeAll()
        
        self.getRantingAndReviews(self.currentObject!)
        self.updateData(self.currentObject)
        
           }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        photo.layer.cornerRadius = photo.frame.height/2
        reviewsImg.layer.cornerRadius = photo.frame.height/2
        
    }
    
    
    // update informations
    func updateData(beer: PFObject?){
        print(beer?.objectForKey("brewery")?.objectId)
        self.name.text = beer!.objectForKey("name") as? String
        self.style.text = beer!.objectForKey("Style") as? String
        

        if beer?.objectForKey("ibu") == nil{
            self.ibuLabel.text = "NC"
        }else{
          let  ibu = beer?.objectForKey("ibu") as! String
            self.ibuLabel.text = ibu
        }
        
        
      
        
        if beer?.objectForKey("abv") == nil{
         self.ibv.text = "NC"
        }else{
        let abv = beer!.objectForKey("abv") as! String
        self.ibv.text = "\(abv)%"
        }
        
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
                        print("Sem imagem")
                        // não tem imagem
                    }
                    
                }else{
                    //erro ao obter imagem
                }
            })
        }else{
            self.photo.image = UIImage(named:"DefaultBeer.png")

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
        
        if UserServices.loggedUser(){
        self.performSegueWithIdentifier("segueReview", sender: nil)
        }else{
           self.alert("Atenção", message: "Você precisa estar logado para fazer isso", option: false, action: nil)
            
        }
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueBeer"{
            if let destination = segue.destinationViewController  as? BreweryVC{
               
                destination.delegate = self

                
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

extension BeerProfileVC: UITableViewDataSource{

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.rev != nil {
            print(self.rev?.count)
           return (self.rev?.count)!
        }
        
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.listOfBeers.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ReviewFromBeerTableViewCell
        

            if self.rev![indexPath.row].objectForKey("user") != nil{
                    
                let user = rev![indexPath.row].objectForKey("user") as! PFUser

                
                
                if user.objectForKey("photo") != nil{
                    let imageUser = user.objectForKey("photo") as! PFFile
                    ImageDAO.getImageFromParse(imageUser, ch: { (image, success) -> Void in
                        if success{
                           cell.userPhotoReview.image = image
                            
                            cell.layoutIfNeeded()
                            cell.userPhotoReview.layer.borderWidth = 1
                            cell.userPhotoReview.layer.masksToBounds = false
                            cell.userPhotoReview.layer.borderColor = UIColor.blackColor().CGColor
                            cell.userPhotoReview.clipsToBounds = true
                            cell.userPhotoReview.layer.cornerRadius = cell.userPhotoReview.frame.height/2
                        }else{
                            //carregar imagem cervejaria away
                        }
                    })
                }else{
                    // imagem nula carregar imagem away
                }
                
             
                cell.userNameReview.text = user.objectForKey("name") as? String
                cell.commentReview.text = self.rev![indexPath.row].objectForKey("comment") as? String
                
                let rate = self.rev![indexPath.row].objectForKey("rating") as? Float
        
                    if user == User.currentUser() {
                        cell.rateReview.text =  String(format: "= %.2f", rate!)
                        self.rateUser.text =  String(format: "= %.2f", rate!)
                    }else{
                        cell.rateReview.text =  String(format: "= %.2f", rate!)
                    }
                
            }
        
        return cell
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var userComment = self.rev![indexPath.row].objectForKey("comment") as? String
        
        if userComment == ""{
            self.alert("Avaliação sem comentário", message: userComment!, option: false, action: nil)
        }else{
           self.alert("Comentário", message: userComment!, option: false, action: nil)
        }
        
    }
    
}
    
    
// MARK:- get ratting and Review
extension BeerProfileVC{
    
    private func getRantingAndReviews(beer:PFObject){
        ReviewDAO.findReviewAndRating(beer) { (reviews, rate, success) -> Void in
            //print(reviews)
            if success{
                
                
                if rate == 0 {
                    self.rateLabel.text = "S/N"
                } else {
                    self.rateLabel.text = NSString(format: "%.1f", rate) as String
                    
                }
                
                if reviews != nil{
                for r in reviews!{
                     //print(r)
                  
                    self.rev?.append(r)
                }
                }
                //print("meus rev:\(self.rev)")
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.reviewsTable.reloadData()
                })
                
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


