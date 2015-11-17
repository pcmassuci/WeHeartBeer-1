//
//  BreweryVC.swift
//  WeHeartBeer
//
//  Created by Paulo César Morandi Massuci on 04/11/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import UIKit
import Parse

class BreweryVC: UIViewController {
    
    
    //Outlets
    @IBOutlet weak var logoBrewery: UIImageView!
    
    @IBOutlet weak var nameBrewery: UILabel!
    
    @IBOutlet weak var placeBrewery: UILabel!
    
    @IBOutlet weak var linkBrewery: UILabel!
    
    @IBOutlet weak var listOfProducts: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    

    var brewery : [Brewery]! = [Brewery]()
     var currentObject: String?

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        

        
     let pointerReceive = "Cervejaralho"
        
        self.activityIndicator.startAnimating()
        
        BreweryServices.findBreweryName(pointerReceive) { (brewery, success) -> Void in
            self.activityIndicator.stopAnimating()
            if success {
                
               self.brewery = brewery
                
                
                print(self.brewery[0].objectForKey("local") )
                self.updateData(self.brewery[0])
                
                
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
        logoBrewery.image = brewery.objectForKey("photo") as? UIImage
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
