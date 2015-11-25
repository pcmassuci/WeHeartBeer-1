//
//  BreweryVC.swift
//  WeHeartBeer
//
//  Created by Paulo César Morandi Massuci on 04/11/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import UIKit
import Parse

class BreweryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    
    //Outlets
    @IBOutlet weak var logoBrewery: UIImageView!
    
    @IBOutlet weak var nameBrewery: UILabel!
    
    @IBOutlet weak var placeBrewery: UILabel!
    
    @IBOutlet weak var linkBrewery: UILabel!
    
    @IBOutlet weak var listOfProducts: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var brewery :Brewery!
    var currentBrewery: PFObject?
    var beers:[Beer]! = [Beer]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(currentBrewery)
        print(currentBrewery?.objectId)
        listOfProducts.delegate = self
        listOfProducts.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        let pointer :String = (currentBrewery?.objectId)! as String
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
        
        
        nameBrewery.text = brewery.objectForKey("name") as? String
        
        placeBrewery.text = brewery.objectForKey("local") as? String
        
        linkBrewery.text = brewery.objectForKey("contact") as? String
        //logoBrewery.image = brewery.objectForKey("photo") as? UIImage
        if brewery.objectForKey("photo") != nil{
            let userImageFile = brewery.objectForKey("photo") as! PFFile
            
            userImageFile.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        let image = UIImage(data:imageData)
                        self.logoBrewery.image = image
                    }else{
                        print("sem imagem")
                    }
                }
                
            }
        }else{
            print("erro na imagem")
        }
        print(self.currentBrewery?.objectId)
        BeerServices.findBeerFromBrewery(self.currentBrewery?.objectId) { (beer, success) -> Void in
            if success{
                self.beers = beer
                print(self.beers)
                self.listOfProducts.reloadData()
                
            }else{
                print("deu Merda")
            }
        }
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Sets number of rows in tableview
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
        
        let cell =  listOfProducts.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! BreweryVCCell
        
        let count = self.beers.count
        if indexPath.row < count{
            cell.beersFromBrew?.text = self.beers[indexPath.row].objectForKey("name") as? String
            //        cell.resutLabel?.text = self.resultsList.objectAtIndex(indexPath.row).objectForKey("name") as? String
        }else{
            cell.beersFromBrew?.text = "ADICIONAR CARVEJA"
            
        }
        
        
        return cell
    }
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
