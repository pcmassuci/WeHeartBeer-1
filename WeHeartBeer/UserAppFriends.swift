//
//  UserAppFriends.swift
//  BeerLove
//
//  Created by Paulo César Morandi Massuci on 12/02/16.
//  Copyright © 2016 Fernando H M Bastos. All rights reserved.
//

import UIKit

class UserAppFriends: UITableViewController {

    
    var countFriends = 0
    var friends = [FBUser]()
    var fbIds = [String]()
    var user = User.currentUser()
    var fbIDCheck = [String?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.friends.removeAll()
        self.view.layoutIfNeeded()
        getFBAppFriends(nil, failureHandler: {(error)
            in print(error)})

    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueToFriendProfile"{
            
            if let destination = segue.destinationViewController  as? FriendProfileVC{
                if let indexPath = tableView.indexPathForSelectedRow?.row{
                    //envia o fbid para a tela de amigo
                    print("valor de referencia \(self.friends[indexPath].fBiD)")
                    let id = self.friends[indexPath].fBiD
                    destination.currentFriend = id
                    //destination.delegate = self
                    
                }
            }
        }
        
        
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
    
    extension UserAppFriends{
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
       return 1
    
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.countFriends  = self.friends.count
        if self.countFriends == 0{
            return 1
        } else {
            
            return self.countFriends
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell =  tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UserAppCell
        
        if self.countFriends == 0 {
                cell.name.text = "Sem Amingos Utilizando o APP"
            }else{
                cell.name.text = self.friends[indexPath.row].name
                
                
            }
            return cell
        }
        
        
        // MARK: - Table view data Delegate
        override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            if self.countFriends != 0 {
                performSegueWithIdentifier("segueToFriendProfile", sender: indexPath)
               
                
            }
        }
}

// MARK: - Facebook Methods
extension UserAppFriends {

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
                  
                    let resultdict = result as! NSDictionary
                    let data : NSArray = resultdict.objectForKey("data") as! NSArray
                    
                    for i in 0..<data.count {
                        let valueDict : NSDictionary = data[i] as! NSDictionary
                        let id = valueDict.objectForKey("id") as! String
                        let name = valueDict.objectForKey("name") as! String
                        self.fbcheck(name, id: id)

                    }
                    if let after = ((resultdict.objectForKey("paging") as? NSDictionary)?.objectForKey("cursors") as? NSDictionary)?.objectForKey("after") as? String {
                        self.getFBAppFriends(after, failureHandler: {(error) in
                            print("error")})
                    } else {
                        
                        self.tableView.reloadData()
                        
                    }
                }
                
            }
            
        }
        
        
    
    func fbcheck(name:String, id:String){
        var check = true
        for fb in fbIDCheck{
            if fb == id{
                check = false
            }
        }
        if check{
            self.friends.append(FBUser(name: name, id: id))
        }
        
    }
    
   
        
        
}

extension UserAppFriends: FriendProfileVCDelegate {
    
    func addIdFriend(id: String){
        self.fbIDCheck.append(id)
    }

    
}

    

