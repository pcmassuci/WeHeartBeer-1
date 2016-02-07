//
//  UserInviteFBFriendsVC.swift
//  BeerLove
//
//  Created by Paulo César Morandi Massuci on 13/01/16.
//  Copyright © 2016 Fernando H M Bastos. All rights reserved.
//

import UIKit

class UserInviteFBFriendsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var countFriends = 0
    //var friends:[User]? = [User]()
    let testeArray = ["julio", "fernado", "mateus"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tintBarUp(self.view)
        self.tableView.delegate = self
        self.tableView.dataSource = self

        // Do any additional setup after loading the view.
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
extension UserInviteFBFriendsVC: UITableViewDataSource , UITableViewDelegate{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //self.countFriends = (self.friends?.count)!
        self.countFriends  = self.testeArray.count
        let rows = self.countFriends + 1
        print(rows)
        return rows
    }
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print(indexPath.row)
        let cell =  tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UserInviteCell
        
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
            print("nós que voa bruxão")
            //performSegueWithIdentifier("segueToAddFriend", sender: nil)
        }else{
            print(testeArray[indexPath.row])
            
        }
    }
    
    
    
    
}

