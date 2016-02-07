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
        self.tintBarUp(self.view)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //self.userFriends()

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
                    //envia o fbid para a tela de amigo
                    print("valor de referencia \(self.friends[indexPath].fBiD)")
                    let id = self.friends[indexPath].fBiD
                    destination.currentFriend = id
                    destination.delegate = self
                    
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
        //print(rows)
        return rows
    }
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //print(indexPath.row)
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



///fbmethods
extension UserAddAppFriendsVC{
    
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
                    self.fbcheck(name, id: id)
                    //self.friends.append(FBUser(name: name, id: id))
                    
                    
                    //                    let pictureDict = valueDict.objectForKey("picture") as! NSDictionary
                    //                    let pictureData = pictureDict.objectForKey("data") as! NSDictionary
                    //                    let pictureURL = pictureData.objectForKey("url") as! String
                    //print("Name: \(name)")
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

extension UserAddAppFriendsVC{
    
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

extension UserAddAppFriendsVC: FriendProfileVCDelegate {
    
    func addIdFriend(id: String){
        self.fbIDCheck.append(id)
    }
//    extension BeerProfileVC: BreweryVCDelegate{
//        func newBeer(objIDbeer:PFObject?) {
//            self.currentObject = objIDbeer
//            print("passou o dado")
//            print(self.currentObject)
//            self.updateData(objIDbeer)
//        }
//        
//        
//    }

    
}



