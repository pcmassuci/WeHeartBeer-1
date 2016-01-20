//
//  UserFriendsVC.swift
//  BeerLove
//
//  Created by Fernando H M Bastos on 12/9/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit
import ParseFacebookUtilsV4


class UserFriendsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var requests:[PFObject?] = [PFObject]()
    var myFriends: [PFObject?] = [PFObject]()
    var waitingFriends:[PFObject?] = [PFObject]()
    let testView: UIView = UIView(frame: CGRectMake(0, 0, 320, 568))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
       
    }
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadingView(true)
        self.requests.removeAll()
        self.waitingFriends.removeAll()
        self.myFriends.removeAll()
        self.queryFriends()
        
        self.tableView.reloadData()

        
        }


    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "segueToAddFriend") {
            
        }
    }

}


/////// DOA TROPA NA GUERRA PRA MIM :)



extension UserFriendsVC: UITableViewDataSource , UITableViewDelegate{
    
     
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        switch section {
            
        case 0:
            return (self.requests.count + 1)
        
        case 1:
            
            if self.waitingFriends.count == 0 {
                return 1
            } else {
            return self.waitingFriends.count
            }
            
        case 2:
            if self.myFriends.count == 0{
                return 1
            } else {
                return self.myFriends.count
  
            }
            
        default :
            return 1
        }
    }
    
    
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var header:String = ""
        
        switch section {
            case 0:
            header = "Solicitações"
            case 1:
            header = "Pendente"
            case 2:
            header = "Amigos"
        default:
            break
        }
        return header
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell =  tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UserFriendsCell
            
        
        switch indexPath.section {
        case 0:
             if indexPath.row == (self.requests.count){
                        cell.name.text = "adicione um amigo"
                    }else{
                        cell.name.text = (self.requests[indexPath.row]!.valueForKey("id1") as! String)
                
                    }
             
        case 1:
            if 0 == (self.waitingFriends.count){
                cell.name.text = "sem requisição"
            }else{
                cell.name.text = (self.waitingFriends[indexPath.row]!.valueForKey("id1") as! String)
            }
            break
            
        case 2:
            if 0 == (self.myFriends.count){
                cell.name.text = "sem amigos"
            }else{
                cell.name.text = (self.myFriends[indexPath.row]!.valueForKey("id1") as! String)
                break
            }
        default:
                break

        }
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        if indexPath.section == 0 {
            if indexPath.row == (self.requests.count){
                performSegueWithIdentifier("segueToAddFriend", sender: nil)
            }else{
                print(self.requests[indexPath.row])
            }
        }
    }
    
    
    
}

extension UserFriendsVC {
    
    
    func queryFriends(){
        let user = User.currentUser()
        let query = PFQuery(className: "Friends")
        query.whereKey("id1", equalTo: (user?.faceID)!)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) f1 scores.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        print(object.objectId)
                        if object.valueForKey("accepted") != nil{
                            if object.valueForKey("accepted") as? Bool  == false {
                                self.requests.append(object)
                                
                            }else{
                                self.waitingFriends.append(object)
                            }
                        }

                    }
                    let qry = PFQuery(className: "Friends")
                    qry.whereKey("id2", equalTo: (user?.faceID)!)
                    query.findObjectsInBackgroundWithBlock({ (objs:[PFObject]?, erro: NSError?) -> Void in
                        if erro == nil{
                            if let objs = objs{
                                for obj in objs{
                                    
                                    print(obj.objectId)
                                    if obj.valueForKey("accepted") != nil{
                                    if obj.valueForKey("accepted") as! Bool  == false {
                                        self.requests.append(obj)
                                        
                                    }else{
                                        self.myFriends.append(obj)
                                    }
                                    }
                                }
                            }
                            
                        }else{
                          print("Error: \(error!) \(error!.userInfo)")
                        }
                    })
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
            print(self.requests.count)
            print(self.myFriends.count)
        }
       self.loadingView(false)
        
    }
    
    func loadingView(option:Bool){
        if option{
    
            //let testView: UIView = UIView(frame: CGRectMake(0, 0, 320, 568))
            self.testView.backgroundColor = UIColor.blueColor()
            self.testView.alpha = 0.5
            self.testView.tag = 100
            super.view.userInteractionEnabled = false
            self.view.userInteractionEnabled = true
            self.view.addSubview(testView)
        }else{
            self.testView.removeFromSuperview()
        }
    }
    

    
}