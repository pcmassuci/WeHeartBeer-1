//
//  FriendsFromMyFriends.swift
//  BeerLove
//
//  Created by Paulo César Morandi Massuci on 11/02/16.
//  Copyright © 2016 Fernando H M Bastos. All rights reserved.
//

import UIKit

class FriendsFromMyFriends: UITableViewController {

    var currentFriends = [String:PFObject?]()
    var names = [String]()
    var objs = [PFObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
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
        

        // Configure the cell...

        return cell
    }
    

 

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

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
        


