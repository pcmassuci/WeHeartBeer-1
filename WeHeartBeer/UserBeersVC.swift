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

class UserBeersVC: UIViewController {
    
    

    @IBOutlet weak var nameBeer: UILabel!
    @IBOutlet weak var listOfBeers: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var userBeer :Brewery!
    var currentBeer: PFObject?
    var beers:[Beer]! = [Beer]()
    var cellControl: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255.0/255.0, green: 192.0/255.0, blue: 3.0/255.0, alpha: 1.0)
        
        
        print(currentBeer)
        print(currentBeer?.objectId)
        listOfBeers.delegate = self
        listOfBeers.dataSource = self
        listOfBeers.tableFooterView = UIView(frame: CGRect.zero)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255.0/255.0, green: 192.0/255.0, blue: 3.0/255.0, alpha: 1.0)
    }
    
    
    

    
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        let pointer :String = (currentBeer?.objectId)! as String
        print(pointer)
        self.activityIndicator.startAnimating()
        BreweryServices.findBreweryObjectID(pointer) { (brewery, success) -> Void in
            //BreweryServices.findBreweryName(pointerReceive) { (brewery, success) -> Void in
            self.activityIndicator.stopAnimating()
            if success {
                
                self.brewery = brewery
                
                
                print(self.brewery.objectForKey("local") )
                self.updateData(self.brewery)
                
                
            }else{
                //colocar aviso de erro para o usuário
            }
        }
        
        
    }
    
    
    // update labels
    func updateData(brewery: Brewery){
        
        
        nameBeer.text = brewery.objectForKey("name") as? String
        

        print(self.currentBeer?.objectId)
        BeerServices.findBeerFromBrewery(self.currentBeer?.objectId) { (beer, success) -> Void in
            if success{
                self.beers = beer
                print(self.beers)
                self.listOfBeers.reloadData()
                
            }else{
                print("não conseguiu conectar")
            }
        }
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

// MARK: - TableView


extension UserBeersVC: UITableViewDataSource, UITableViewDelegate {
    // Sets number of rows in tableview
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        
        return 35
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
        
        let cell =  listOfBeers.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! BreweryVCCell
        
        let count = self.beers.count
        self.cellControl = count
        
        if indexPath.row < count{
            cell.beersFromBrew?.text = self.beers[indexPath.row].objectForKey("name") as? String
            //        cell.resutLabel?.text = self.resultsList.objectAtIndex(indexPath.row).objectForKey("name") as? String
            
        }
        
        
        return cell
    }
    
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //            print("valor do obejto")
        //            print(self.beers[indexPath.row])
        
        print(self.cellControl)
        print(indexPath.row)
        if (indexPath.row == cellControl) {
            self.performSegueWithIdentifier("segueToAddBeer", sender: self)
            
            
        }else{
            delegate?.newBeer(self.beers[indexPath.row])
            if let navController = self.navigationController {
                navController.popViewControllerAnimated(true)
            }else{
                
                print("optional value")
                
                
            }
        }

    }
    


    
    
    
}
