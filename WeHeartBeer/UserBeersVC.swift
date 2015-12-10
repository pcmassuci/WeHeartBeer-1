//
//  UserBeersVC.swift
//  BeerLove
//
//  Created by Fernando H M Bastos on 12/9/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import UIKit
import Foundation


typealias FindObjsCH = (beer:[PFObject]?,success:Bool) -> Void
typealias FimdOBjCh = (obj:PFObject?,success:Bool) -> Void

class UserBeersVC: UIViewController {
    
    //@IBOutlet weak var tableView: UITableView!
    
    var user = User.currentUser()
   // var userBeers:[PFObject?]=[PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255.0/255.0, green: 192.0/255.0, blue: 3.0/255.0, alpha: 1.0)
        print(user)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.findBeersFromUser { (beer, success) -> Void in
            if success{
//                self.userBeers = beer!
//                print(beer?.count)
//                beer?.count
                
            }
        }
    }

    
    
    func findBeersFromUser(completionHandler:FindObjsCH){
        var query = PFQuery(className:"Review")
        query.whereKey("user", equalTo:user!)
        query.findObjectsInBackgroundWithBlock { (result:[PFObject]?, error:NSError?) -> Void in
            if error == nil {
                if let result = result as? [PFObject]? {
                    completionHandler(beer: result, success: true)
                }else{
                    print("erro dao")
                    completionHandler(beer:nil,success: false)
                }
            }else{
                print("erro dao 2")
                completionHandler(beer:nil,success: false)
            }
            
            
        }
        
    }
    
    
//    func findBeer(objID: String!, completionHandler:FindObjectCompletionHandler){
//        var query = PFQuery(className:"Beer")
//        query.getObjectInBackgroundWithId(objID) { (result:PFObject?, error:NSError?) -> Void in
//            if error == nil {
//                if let result = result as? PFObject? {
//                    completionHandler(obj: result, success: true)
//                }else{
//                    print("erro dao")
//                    completionHandler(obj:nil,success: false)
//                }
//            }else{
//                print("erro dao 2")
//                completionHandler(obj:nil,success: false)
//            }
//            
//        }
//    }
    
//    func updateData(beer: PFObject?){
//        
//        // pegando a foto do parse
//        
//        if beer!.objectForKey("Photo") != nil{
//            let userImageFile = beer!.objectForKey("Photo") as! PFFile
//            
//            userImageFile.getDataInBackgroundWithBlock {
//                (imageData: NSData?, error: NSError?) -> Void in
//                if error == nil {
//                    if let imageData = imageData {
//                        let image = UIImage(data:imageData)
//                        //self.image.image = image
//                       // self.image.contentMode = UIViewContentMode.ScaleAspectFit
//                        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
//                        //self.image.userInteractionEnabled = true
//                        //self.image.addGestureRecognizer(tapGestureRecognizer)
//                        
//                    }else{
//                        print("sem imagem")
//                    }
//                }
//                
//            }
//        }else{
//            print("erro na imagem")
//        }
}
//    extension UserBeersVC: UITableViewDataSource, UITableViewDelegate{
//        
//        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return userBeers.count
//            
//        }
//        
//        func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//            return 1
//        }
//        
//        
//        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//             let cell =  tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UserBeersTVCell
//           // cell.beersLabel.text =
//             return cell
//        }
//        
//        
//        
//        
//    }

    
    


