//
//  UserBeersVC.swift
//  BeerLove
//
//  Created by Fernando H M Bastos on 12/9/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import UIKit
import Foundation
import Parse

protocol UserBeersVCDelegate{
    func newReview(objIDUser:PFObject?)
}

class UserBeersVC: UIViewController {
    var delegate: UserBeersVCDelegate?

    @IBOutlet weak var listOfBeers: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var reviews: [Review]!
    var beers: [Beer]!
    var cellControl: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 250.0/255.0, green: 170.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        
        self.beers = [Beer]()
        self.reviews = [Review]()

        ReviewServices.findReviewfromUser(User.currentUser()!) { (reviews, success) -> Void in
            for i in 0..<reviews!.count {
                let review = reviews![i]
                self.reviews.append(review)

                let beer = review.objectForKey("beer") as! Beer
                self.beers.append(beer)
            }
            self.listOfBeers.reloadData()
        }
        
        listOfBeers.delegate = self
        listOfBeers.dataSource = self
        listOfBeers.tableHeaderView = UIView(frame: CGRect.zero)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255.0/255.0, green: 170.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - TableView
extension UserBeersVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label: UILabel = UILabel()
        label.text = "Cervejas"
        label.textColor = UIColor.blackColor()
        label.backgroundColor = UIColor(red: 255.0/255.0, green: 170.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        
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
            let userImageFile = self.beers[indexPath.row].objectForKey("Photo")
            
            userImageFile!.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        let image = UIImage(data:imageData)
                        cell.imageBeersFromUser.image = image
                    }else{
                        print("sem imagem")
                        cell.imageBeersFromUser.image = nil
                    }
                }
                
            }
        }else{
            print("erro na imagem")
            cell.imageBeersFromUser.image = nil
        }
        
        
        cell.beersFromUser?.text = self.beers[indexPath.row].objectForKey("name") as? String
        cell.breweryFromUser?.text = self.beers[indexPath.row].objectForKey("brewName") as? String
        
        if let rating = self.reviews[indexPath.row].valueForKey("rating") {
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueBeerReviewToBeer" {
            let destination = segue.destinationViewController as! BeerProfileVC
            let indexPath = sender as! NSIndexPath
            let review = self.reviews[indexPath.row]
            let beer = self.beers[indexPath.row]
            
            destination.idReview = review
            destination.currentObject = beer
        }
    }
}
