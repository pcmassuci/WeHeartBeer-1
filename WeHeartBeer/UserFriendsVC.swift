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
    var countFriends = 0
    //var friends:[User]? = [User]()
    let testeArray = ["julio", "fernado", "mateus"]
    var requests:[PFObject?] = [PFObject]()
    var myFriends: [PFObject] = [PFObject]()
    let testeArray1 = ["juliow", "fernawdo", "mateusw"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.queryFriends()
    }
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        //criar reload friends
        tableView.reloadData()
        
//        getFBAppFriends(nil, failureHandler: {(error)
//            in print(error)})
        //self.queryFriends()
        
        }


    // pegar amigos que usam o app
    func getFBAppFriends(nextCursor : String?, failureHandler: (error: NSError) -> Void) {
        
        let qry = "/me/friends"
        var parameters = Dictionary<String, String>() as? Dictionary
        if nextCursor == nil {
            parameters = nil
        } else {
            parameters!["after"] = nextCursor
        }
        
        let request = FBSDKGraphRequest(graphPath: qry, parameters: parameters);
        
        
        request.startWithCompletionHandler { (connection : FBSDKGraphRequestConnection!, result : AnyObject!, error : NSError!) -> Void in
            
            if (error) != nil{
                // Process error
                print("Error: \(error)")
                
            }else{
                //println("fetched user: \(result)")
                let resultdict = result as! NSDictionary
                let data : NSArray = resultdict.objectForKey("data") as! NSArray
                
                for i in 0..<data.count {
                    let valueDict : NSDictionary = data[i] as! NSDictionary
                    //                    let id = valueDict.objectForKey("id") as! String
                    let name = valueDict.objectForKey("name") as! String
                    //                    let pictureDict = valueDict.objectForKey("picture") as! NSDictionary
                    //                    let pictureData = pictureDict.objectForKey("data") as! NSDictionary
                    //                    let pictureURL = pictureData.objectForKey("url") as! String
                    print("Name: \(name)")
                    //println("ID: \(id)")
                    //println("URL: \(pictureURL)")
                }
                if let after = ((resultdict.objectForKey("paging") as? NSDictionary)?.objectForKey("cursors") as? NSDictionary)?.objectForKey("after") as? String {
                    self.getFBAppFriends(after, failureHandler: {(error) in
                        print("error")})
                } else {
                    print("Can't read next!!!")
                }
            }
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "segueToAddFriend") {
            print("ola")
            
        }
    }

}

extension UserFriendsVC: UITableViewDataSource , UITableViewDelegate{
    
    
 
        
        
     
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //self.countFriends = (self.friends?.count)!
        self.countFriends  = self.testeArray.count
        let rows = self.countFriends + 1
        print(rows)
        return rows
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = HeaderSecFriends()
//        if section == 0 {
//            view.sectionName.text = "Solicitações"
//        }else{
//            view.sectionName.text = "Amigos"
// 
//        }
//        
        return view
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            
            let cell =  tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UserFriendsCell
            
            if indexPath.row == (self.countFriends){
                cell.name.text = "adicione um amigo"
            }else{
                cell.name.text = self.testeArray[indexPath.row]
                
            }
            break
        case 1:
            let cell =  tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UserFriendsCell
            
            if indexPath.row == (self.countFriends){
                cell.name.text = "adicione um amigo"
            }else{
                cell.name.text = self.testeArray1[indexPath.row]
                
            }

            
            break
        default:
            break
        }
        
        let cell =  tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UserFriendsCell

        if indexPath.row == (self.countFriends){
            cell.name.text = "adicione um amigo"
        }else{
            cell.name.text = self.testeArray[indexPath.row]
            
        }
       // return UITableViewCell()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == (self.countFriends){
            performSegueWithIdentifier("segueToAddFriend", sender: nil)
        }else{
            print(testeArray[indexPath.row])
            
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
                            if object.valueForKey("accepted") as! Bool  == false {
                                self.requests.append(object)
                                
                            }else{
                                self.myFriends.append(object)
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
        
        
    }
    

    
}