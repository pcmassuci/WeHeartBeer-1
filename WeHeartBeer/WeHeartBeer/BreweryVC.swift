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
    
    @IBOutlet weak var logoBrewery: UIImageView!
    
    @IBOutlet weak var nameBrewery: UILabel!
    
    @IBOutlet weak var placeBrewery: UILabel!
    
    @IBOutlet weak var linkBrewery: UILabel!
    
    @IBOutlet weak var listOfProducts: UITableView!
    
 

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        var pointerReceive = "4blpTUoLIz"
        
        var brewery = PFObject(className:"Brewery")
        let query = PFQuery(className:"Brewery")
        query.getObjectInBackgroundWithId(pointerReceive) {
            (brewery: PFObject?, error: NSError?) -> Void in
            if error == nil && brewery != nil {
                print(brewery)
                
                let name = brewery!["name"] as! String
                let place = brewery!["local"] as! String
                let link = brewery!["contact"] as! String
                self.updateData(name, place: place, link: link)
            } else {
                print(error)
                //lembrar de colocar alerta, e ação caso nao seja encontrado a cervejaria
                
            }
        }
        
      

    }
    
    
    func updateData(name:String!, place:String!, link:String!){
        
    
    nameBrewery.text = name
    placeBrewery.text = place
    linkBrewery.text = link
    
 
    
    
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
