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
    
    var idsFace = [String?]()
    var requests:[PFObject?] = [PFObject]()
    var myFriends: [PFObject?] = [PFObject]()
    var waitingFriends:[PFObject?] = [PFObject]()
    //let testView: UIView = UIView(frame: CGRectMake(0, 0, 320, 320))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()

        self.tintBarUp(self.view)
        let check = self.internetCheck()
        if check{
            
        }
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.navigationController?.navigationBar.hidden = false
        //self.navigationController?.navigationBar.barTintColor = UIColor(red: 250.0/255.0, green: 170.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        changeColor()
        // self.navigationController?.navigationController = true
    }
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let usr = User.currentUser()
        //self.loadingView(true)
        self.requests.removeAll()
        self.waitingFriends.removeAll()
        self.myFriends.removeAll()
        self.idsFace.removeAll()

        FriendsDAO.queryFriends { (requests, waitingFriends, myFriends, success) -> Void in
            if success{
                print("uma vez")
                if requests! == requests!{
                    for request in requests!{
                        self.requests.append(request)
                        self.idsFace.append(request.objectForKey("id1") as? String)
                    }
                }
                if waitingFriends! == waitingFriends!{
                    for wf in waitingFriends!{
                        self.waitingFriends.append(wf)
                        self.idsFace.append(wf.objectForKey("id2") as? String)

                        //print(wf)
                    }
                }
                
                for mf in myFriends!{
                   
                    let mfID = mf.objectForKey("id1") as! String
                    if mfID == usr?.faceID{
                        self.idsFace.append(mf.objectForKey("id2") as? String)
                    }else{
                        self.idsFace.append(mfID)
                    }
                    
                    self.myFriends.append(mf)
                    
                }
            
                self.tableView.reloadData()
            }else{
                print("deu erro")
        }
        
        }
        
        
        self.tableView.reloadData()

        
        }


    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "segueToFriendProfile") {
            if let destination = segue.destinationViewController  as? FriendProfileVC{
                if let indexPath = tableView.indexPathForSelectedRow{
                    switch indexPath.section{
                    case 0:
                        let id = (self.requests[indexPath.row]!.objectForKey("id1") as! String)
                        destination.currentFriend = id
                        break
                    case 1:
                        let id = (self.waitingFriends[indexPath.row]!.objectForKey("id2") as! String)
                        destination.currentFriend = id
                        break
                    case 2:
                        if (sender as! Bool){
                            let id = (self.myFriends[indexPath.row]!.objectForKey("id1") as! String)
                            destination.currentFriend = id
                        }else{
                            let id = (self.myFriends[indexPath.row]!.objectForKey("id2") as! String)
                            destination.currentFriend = id
                        }
                        
                        break
                    default:
                        break
                        
                    }
              
                }
            }
        }

        if (segue.identifier == "segueToAddFriend") {
            if let destination = segue.destinationViewController  as? UserAppFriends{
                print(self.idsFace)
                        destination.fbIDCheck = self.idsFace
            }
            
        }
    }

}




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
    
     func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor(red: 243/255, green: 153/255, blue: 18/255, alpha: 1.0) //make the background color light blue
        header.textLabel!.textColor = UIColor.whiteColor() //make the text white
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
                        cell.name.text = "Ache amigos que já usam o app"
                        cell.name.numberOfLines = 0
                        cell.backgroundColor = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 0.8)
                
                
                    }else{
                        cell.name.text = (self.requests[indexPath.row]!.objectForKey("name1") as! String)
                
                    }
             
        case 1:
            if 0 == (self.waitingFriends.count){
                cell.name.text = "Sem solicitações pendentes"
                cell.backgroundColor = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 0.8)
            }else{
                //print(self.waitingFriends[indexPath.row]?.objectForKey("name2"))
                cell.name.text = (self.waitingFriends[indexPath.row]?.objectForKey("name2") as! String)
                //(self.waitingFriends[indexPath.row]!.valueForKey("id1") as! String)
            }
            break
            
        case 2:
            if 0 == (self.myFriends.count){
                cell.name.text = "sem amigos"
               
            }else{
                let id = self.myFriends[indexPath.row]!.objectForKey("id1") as? String
                let user = User.currentUser()
                if user?.faceID == id {
                    cell.name.text = (self.myFriends[indexPath.row]!.objectForKey("name2") as! String)
                    break
   
                }else{
                    cell.name.text = (self.myFriends[indexPath.row]!.objectForKey("name1") as! String)
                    break

                }
            }
        default:
                break

        }
        
                return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("section:\(indexPath.section) , row: \(indexPath.row)")
        

        
        switch indexPath.section{
        case 0:
            if indexPath.row == (self.requests.count){
                performSegueWithIdentifier("segueToAddFriend", sender: nil)
                
            }else{
                performSegueWithIdentifier("segueToFriendProfile", sender: nil)
            }
            break
        case 1:
            if self.waitingFriends.count == 0 {
                self.alert("Atenção!", message: "Você não tem nenhum pedido de amizade pendente, adicione mais amigos.", option: false, action: nil)
                
            }else{
             performSegueWithIdentifier("segueToFriendProfile", sender: nil)
            }
            break
        case 2:
            
            if 0 == (self.myFriends.count){
                self.alert("Atenção!", message: "Você não tem amigos.", option: false, action: nil)
            }else{
                let id = self.myFriends[indexPath.row]!.objectForKey("id1") as? String
                let user = User.currentUser()
                if user?.faceID == id {
                    performSegueWithIdentifier("segueToFriendProfile", sender: false)
                    break
                    
                }else{
                   performSegueWithIdentifier("segueToFriendProfile", sender: true)
                    break
                    
                }
            }

    default:
            break
            
        }
        
     
    }
    
        
        
        
        
        
}

extension UserFriendsVC {

    
    func loadingView(option:Bool){
//        let screenSize: CGRect = UIScreen.mainScreen().bounds
//
//        let screenWidth = (screenSize.width/2)
//        let screenHeight = (screenSize.height/2)
//        let size = CGRectMake(screenWidth, screenHeight, 700, 700)
//        let testView: UIView = UIView(frame: size)
//       // let testView: UIView = UIView(frame: CGRectMake(0, 0, 320, 568))
//        if option{
//    
//        
//            testView.backgroundColor = UIColor.blackColor()
//            testView.alpha = 0.5
//            testView.tag = 100
//            self.view.userInteractionEnabled = false
//            self.view.userInteractionEnabled = true
//            self.view.addSubview(testView)
//        }else{
//            testView.removeFromSuperview()
//        }
    }
    

    
}