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

    var userBeer = User.currentUser()
    var currentReview: PFObject?
    var beers:[Beer]! = [Beer]()
    var cellControl: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255.0/255.0, green: 192.0/255.0, blue: 3.0/255.0, alpha: 1.0)
        
        ReviewServices.findReviewfromUser(userBeer!.objectId!) { (Review, success) -> Void in
            print(Review)
        }
    
        
        print(currentReview)
        print(currentReview?.objectId)
        listOfBeers.delegate = self
        listOfBeers.dataSource = self
        listOfBeers.tableFooterView = UIView(frame: CGRect.zero)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255.0/255.0, green: 192.0/255.0, blue: 3.0/255.0, alpha: 1.0)
    }
    
    
    
 
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        /*let pointer :String = (currentReview?.objectId)! as String
        print(pointer)
        self.activityIndicator.startAnimating()
        BeerServices.findBeerName(pointer) { (userBeer, success) -> Void in
            //BreweryServices.findBreweryName(pointerReceive) { (brewery, success) -> Void in
            self.activityIndicator.stopAnimating()
            if success {
                
                //self.userBeer = self.userBeer
                
                
                print(self.userBeer.objectForKey("local") )
                self.updateData(self.userBeer)
                
                
            }else{
                //colocar aviso de erro para o usuário
            }
        }
        
        */
    }
    
    
    // update labels
//    func updateData(UserBeers: User){
//        
//        
//        self.BeersFromUser.text = userBeer!.objectForKey("beer") as? String
//        
//print(BeersFromUser.text)
//        print(self.currentReview?.objectId)
//        BeerServices.findBeerFromBrewery(self.currentReview?.objectId) { (beer, success) -> Void in
//            if success{
//                self.beers = beer
//                print(self.beers)
//                self.listOfBeers.reloadData()
//                
//            }else{
//                print("não conseguiu conectar")
//            }
//        }
//        
//    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

// MARK: - TableView


extension UserBeersVC: UITableViewDataSource, UITableViewDelegate {
    // Sets number of rows in tableview
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        
        return 10
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label: UILabel = UILabel()
        label.text = "Cervejas"
        label.textColor = UIColor.blackColor()
        label.backgroundColor = UIColor(red: 255.0/255.0, green: 192.0/255.0, blue: 3.0/255.0, alpha: 1.0)
        
        return label
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count = self.beers.count
        count += 1
        
        
        
        return count
        //}
    }
    
    // Number of sections in tableview - not used
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //Sets the tableview cell and change its info to the correspondent object
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell =  listOfBeers.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ReviewVCCell
        
        let count = self.beers.count
        self.cellControl = count
        
        if indexPath.row < count{
            cell.beersFromUser?.text = self.beers[indexPath.row].objectForKey("user") as? String
            //        cell.resutLabel?.text = self.resultsList.objectAtIndex(indexPath.row).objectForKey("name") as? String
            
        }
        
        
        return cell
    }
    
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        print(self.cellControl)
        print(indexPath.row)
        if (indexPath.row == cellControl) {
            //self.performSegueWithIdentifier("segueToAddBeer", sender: self)
            
            
        }else{
            delegate?.newReview(self.beers[indexPath.row])
            if let navController = self.navigationController {
                navController.popViewControllerAnimated(true)
            }else{
                
                print("optional value")
                
                
            }
        }

    }
    


    
    
    
}
