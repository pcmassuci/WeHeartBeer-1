//
//  BreweryVC.swift
//  WeHeartBeer
//
//  Created by Paulo César Morandi Massuci on 04/11/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import UIKit
import Parse

protocol BreweryVCDelegate{
    func newBeer(objIDbeer:PFObject?)
}


class BreweryVC: UIViewController{
    var delegate: BreweryVCDelegate?
    
    
    
    
    
    
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
    var cellControl: Int = 0
    
    
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
    

    extension BreweryVC: UITableViewDataSource, UITableViewDelegate {
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
            self.cellControl = count
            
            if indexPath.row < count{
                cell.beersFromBrew?.text = self.beers[indexPath.row].objectForKey("name") as? String
                //        cell.resutLabel?.text = self.resultsList.objectAtIndex(indexPath.row).objectForKey("name") as? String
            }else{
                cell.beersFromBrew?.text = "ADICIONAR CARVEJA"
                
            }
            
            
            return cell
        }
        

        
        
        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//            print("valor do obejto")
//            print(self.beers[indexPath.row])
           
             print(self.cellControl)
            print(indexPath.row)
            if (indexPath.row == cellControl) {
                print("verificação 1")
              self.performSegueWithIdentifier("segueToAddBeer", sender: self)
                
                
            }else{
            delegate?.newBeer(self.beers[indexPath.row])
            if let navController = self.navigationController {
                navController.popViewControllerAnimated(true)
            }else{
                
                print("optional value")
                
                
            }
            }
            //        if let del = delegate{
            //
            //            del.newBeer(self.beers[indexPath.row])
            //            
            //        }else{
            //            print("erro no delegate")
            //        }
        }
        
          // MARK: - Send to ADDBeer
        // Prepare segue - WIP
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if segue.identifier == "segueToAddBeer"{
                if let destination = segue.destinationViewController  as? AddBeer  {
                    
//                    if let indexPath = self.listOfProducts.indexPathForSelectedRow?.row{
//                        
//                       // let row = Int(indexPath)
                       destination.brewery = self.brewery
                    
//                    }
                    print("chupa fernando")
                }
            }
        
        }
}
