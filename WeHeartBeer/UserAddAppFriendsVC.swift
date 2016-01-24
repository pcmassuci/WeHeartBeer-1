//
//  UserAddAppFriendsVC.swift
//  BeerLove
//
//  Created by Paulo César Morandi Massuci on 13/01/16.
//  Copyright © 2016 Fernando H M Bastos. All rights reserved.
//

import UIKit

class UserAddAppFriendsVC: UIViewController {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    var countFriends = 0
    var friends = [FBUser]()
    var fbIds = [String]()
    var user = User.currentUser()
    var fbIDCheck = [String?]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.userFriends()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.friends.removeAll()
        self.view.layoutIfNeeded()
          getFBAppFriends(nil, failureHandler: {(error)
             in print(error)})
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueToFriendProfile"{
            if let destination = segue.destinationViewController  as? FriendProfileVC{
                if let indexPath = tableView.indexPathForSelectedRow?.row{
                    destination.currentFriend = self.friends[indexPath].fBiD
                    
                }
            }
        }

      
    }


}

extension UserAddAppFriendsVC: UITableViewDataSource , UITableViewDelegate{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //self.countFriends = (self.friends?.count)!
        self.countFriends  = self.friends.count
        let rows = self.countFriends + 1
        print(rows)
        return rows
    }
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print(indexPath.row)
        let cell =  tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UserAppCell
        
        if indexPath.row == (self.countFriends){
            cell.name.text = "Convide para o App"
        }else{
            cell.name.text = self.friends[indexPath.row].name
         
            
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == (self.countFriends){
            
            performSegueWithIdentifier("segueInviteFacebook", sender: nil)
        }else{
            performSegueWithIdentifier("segueToFriendProfile", sender: indexPath)
        //self.showAlertTapped(indexPath.row)
            
        }
    }
    
}
extension UserAddAppFriendsVC{
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
                    let id = valueDict.objectForKey("id") as! String
                    let name = valueDict.objectForKey("name") as! String
                    var control = true
                    if self.fbIDCheck.count > 0{
                        for fbs in self.fbIDCheck {
                            if fbs == id {
                                control = false
                            }
                        }
                    }
                    if control {
                        self.friends.append(FBUser(name: name, id: id))
                    }
                    
                    
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
                    //images.sort({ $0.fileID > $1.fileID })
                    self.tableView.reloadData()
                    
                }
            }
            
        }
        
    }
    
    
}
//Parse
extension UserAddAppFriendsVC{
    
    func parseQuery(){
        
        
        // set up the query on the Follow table
        let query = PFQuery(className: "Friends")
        
        
        
    }
    
    func userFriends(){
        
        var brejas:Int
        if user?.objectForKey("friend")?.count == nil{
        brejas = 0
            
        }else{
            
        brejas = (user?.objectForKey("friend")?.count)!
        
        }
        print("amigos")
        print(brejas)
    }
 
    
}

extension UserAddAppFriendsVC {
    
//    func showAlertTapped(row:Int) {
//        //Create the AlertController
//        let actionSheetController: UIAlertController = UIAlertController(title: "Alerta", message: "Você deseja adicionar \(self.friends[row].name) como amigo", preferredStyle: .Alert)
//        
//        //Create and add the Cancel action
//        let cancelAction: UIAlertAction = UIAlertAction(title: "Não", style: .Cancel) { action -> Void in
//            //Do some stuff
//        }
//        actionSheetController.addAction(cancelAction)
//        //Create and an option action
//        let nextAction: UIAlertAction = UIAlertAction(title: "Sim", style: .Default) { action -> Void in
//            
//            
//            let follow = PFObject(className: "User")
//            var otherUser:PFObject?
//            var query = PFQuery(className:"_User")
//            
//            print(self.friends[row].fBiD)
//            
//            query.whereKey("name", equalTo:(self.friends[row].name as String))
//            query.getFirstObjectInBackgroundWithBlock({ (object: PFObject?, error: NSError?) -> Void in
//                if error == nil {
//                    // The find succeeded
//                            print(object!.objectId)
//                            print(object!.objectForKey("faceID"))
//                    follow.setObject(PFUser.currentUser()!, forKey: "friend")
//                    follow.setObject(object!, forKey: "to")
//                    follow.setObject(NSDate(), forKey: "date")
//                    follow.saveInBackground()
//                    
//                } else {
//                    // Log details of the failure
//                    print("Error ao salvar: \(error!) \(error!.userInfo)")
//                }
//                })
//            
//          
//        }
//        actionSheetController.addAction(nextAction)
//    
//        
//        //Present the AlertController
//        self.presentViewController(actionSheetController, animated: true, completion: nil)
//    }
    
}



