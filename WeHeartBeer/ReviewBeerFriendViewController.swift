//
//  ReviewBeerFriendViewController.swift
//  BeerLove
//
//  Created by Paulo César Morandi Massuci on 11/02/16.
//  Copyright © 2016 Fernando H M Bastos. All rights reserved.
//

import UIKit

class ReviewBeerFriendViewController: UIViewController {
//    
//    @IBOutlet weak var listOfBeers: UITableView!
//    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
//    var reviews: [Review]!
//    var beers: [Beer]!
//    var cellControl: Int = 0
//    var user = PFObject?()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.tintBarUp(self.view)
//        self.navigationController?.navigationBar.hidden = false
//        self.navigationController?.navigationBar.barTintColor = UIColor(red: 250.0/255.0, green: 170.0/255.0, blue: 0.0/255.0, alpha: 1.0)
//        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
//        
//        
//        self.beers = [Beer]()
//        self.reviews = [Review]()
//        
////        ReviewServices.findReviewfromUser(User.currentUser()!) { (reviews, success) -> Void in
////            for i in 0..<reviews!.count {
////                let review = reviews![i]
////                self.reviews.append(review)
////                
////                let beer = review.objectForKey("beer") as! Beer
////                self.beers.append(beer)
////            }
////            self.listOfBeers.reloadData()
////        }
//        
//        listOfBeers.delegate = self
//        listOfBeers.dataSource = self
//        listOfBeers.tableHeaderView = UIView(frame: CGRect.zero)
//        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255.0/255.0, green: 170.0/255.0, blue: 0.0/255.0, alpha: 1.0)
//    }
//    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        ReviewDAO.findReviewFromUser(user!) { (reviews, success) -> Void in
//            for r in reviews!{
//                self.reviews.append(r)
//                let beer = r.objectForKey("beer") as! Beer
//                self.beers.append(beer)
//                
//            }
//            self.listOfBeers.reloadData()
//        }
//        
//    }
//    
//    override func viewWillLayoutSubviews() {
//        
//        
//        
//    }
//    
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//}
//
//// MARK: - TableView
//extension ReviewBeerFriendViewController: UITableViewDataSource, UITableViewDelegate {
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 20
//    }
//    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let label: UILabel = UILabel()
//        label.text = "      Cervejas"
//        label.textColor = UIColor.whiteColor()
//        label.tintColor = UIColor.whiteColor()
//        label.backgroundColor = UIColor(red: 255.0/255.0, green: 170.0/255.0, blue: 0.0/255.0, alpha: 1.0)
//        
//        return label
//    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.beers.count
//    }
//    
//    // Number of sections in tableview - not used
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    
//    //Sets the tableview cell and change its info to the correspondent object
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = listOfBeers.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ReviewFriendVCCell
//        
//        
//        
//        
//        if self.beers[indexPath.row].objectForKey("Photo") != nil{
//            let imageFile = self.beers[indexPath.row].objectForKey("Photo") as! PFFile
//            ImageDAO.getImageFromParse(imageFile, ch: { (image, success) -> Void in
//                if success{
//                    
//                    cell.imageBeersFromUser.image = image
//                    
//                    
//                    cell.imageBeersFromUser.layer.borderWidth = 1
//                    cell.imageBeersFromUser.layer.masksToBounds = false
//                    cell.imageBeersFromUser.layer.borderColor = UIColor.blackColor().CGColor
//                    cell.imageBeersFromUser.clipsToBounds = true
//                    cell.imageBeersFromUser.layer.cornerRadius = cell.imageBeersFromUser.frame.height/2
//                    
//                    
//                }else{
//                    print("sem imagem")
//                    
//                    cell.layoutIfNeeded()
//                    
//                    cell.imageBeersFromUser.layer.borderWidth = 1
//                    cell.imageBeersFromUser.layer.masksToBounds = false
//                    cell.imageBeersFromUser.layer.borderColor = UIColor.blackColor().CGColor
//                    cell.imageBeersFromUser.clipsToBounds = true
//                    cell.imageBeersFromUser.layer.cornerRadius = cell.imageBeersFromUser.frame.height/2
//                    
//                    cell.imageBeersFromUser.image = UIImage(named: "DefaultBeer.png")
//                    
//                }
//            })
//            
//        }else{
//            print("erro na imagem")
//            
//            cell.layoutIfNeeded()
//            
//            cell.imageBeersFromUser.image = UIImage(named:"DefaultBeer.png")
//            
//            cell.imageBeersFromUser.layer.borderWidth = 1
//            cell.imageBeersFromUser.layer.masksToBounds = false
//            cell.imageBeersFromUser.layer.borderColor = UIColor.blackColor().CGColor
//            cell.imageBeersFromUser.clipsToBounds = true
//            cell.imageBeersFromUser.layer.cornerRadius = cell.imageBeersFromUser.frame.height/2
//            
//            
//        }
//        
//        
//        cell.beersFromUser?.text = self.beers[indexPath.row].objectForKey("name") as? String
//        cell.breweryFromUser?.text = self.beers[indexPath.row].objectForKey("brewName") as? String
//        
//        if let rating = self.reviews[indexPath.row].valueForKey("rating") {
//            cell.ratingFromUser?.text = "\(rating)"
//        } else {
//            cell.ratingFromUser?.text = "No rating available"
//        }
//        
//        
//        return cell
//    }
//    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        if indexPath.row < self.beers.count {
//            performSegueWithIdentifier("segueToBeeer", sender: indexPath)
//        }
//        
//             tableView.deselectRowAtIndexPath(indexPath, animated: true)
//    }
//    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "segueToBeeer" {
//            let destination = segue.destinationViewController as! BeerProfileVC
//            let indexPath = sender as! NSIndexPath
//            //let review = self.reviews[indexPath.row]
//            let beer = self.beers[indexPath.row]
//            
//            //destination.idReview = review
//            destination.currentObject = beer
//        }
//    }
//
//
}
