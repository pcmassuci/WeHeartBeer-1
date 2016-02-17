//
//  FriendsFromMyFriends.swift
//  BeerLove
//
//  Created by Paulo César Morandi Massuci on 11/02/16.
//  Copyright © 2016 Fernando H M Bastos. All rights reserved.
//

import UIKit


protocol FriendListVCDelegate{
    func newFriend(friendOb:PFObject)
}
class FriendsFromMyFriends: UITableViewController {
    var delegate: FriendListVCDelegate?
    var currentFriends = [String:PFObject?]()
    var names = [String]()
    var objs = [PFObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        

 
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.objs.removeAll()
        self.names.removeAll()
       // self.currentFriends.removeAll()
        self.separeDict()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        
        if self.names.count != 0 {
            
        return self.names.count
        }
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! FrinMyFrinCell
        print(self.names)
        if self.names.count != 0 {
            cell.imageLabel.hidden = false
            cell.friendLabel.text = self.names[indexPath.row]
        } else{
            cell.imageLabel.hidden = false
            cell.friendLabel.text = "Sem Amigos"
        }
        

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if self.objs.count != 0 {
        
        let query = PFQuery(className:"_User")
        query.whereKey("objectId", equalTo:self.objs[indexPath.row].objectId!)
        query.getFirstObjectInBackgroundWithBlock { (object, error) -> Void in
            if object != nil {
                self.delegate?.newFriend(object!)
                if let navController = self.navigationController {
                    navController.popViewControllerAnimated(true)
                }else{
                    print("optional value")
                }
                
            }else{
                self.alert("Atenção", message: "Houve, um erro ao receber o dado do servidor!", option: false, action: nil)
                
            }
        }
        } else{
            
        }
        
             tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
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
    extension FriendsFromMyFriends {
        private func separeDict(){
            
                for (key, value) in self.currentFriends{
                    self.objs.append(value!)
                    self.names.append(key)
                    
                }
            print(self.names)
            self.tableView.reloadData()
                
            }

        }
        


