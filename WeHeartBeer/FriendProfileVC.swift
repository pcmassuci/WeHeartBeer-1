//
//  FriendProfileVC.swift
//  BeerLove
//
//  Created by Paulo César Morandi Massuci on 18/01/16.
//  Copyright © 2016 Fernando H M Bastos. All rights reserved.
//

import UIKit

protocol FriendProfileVCDelegate{
     func addIdFriend(id: String)
}
class FriendProfileVC: UIViewController {
    
    var delegate: FriendProfileVCDelegate?
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var friendName: UILabel!
    var currentRequest: PFObject?
    var currentFriend: String? = ""
    var choice:Int?
   // var check: Bool
    var friend: PFObject?
    
    
    override func viewDidLoad() {
       
        
        super.viewDidLoad()
        self.internetCheck()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print(self.currentFriend)
        if self.currentFriend != nil{
 //Request to server Frienduser data
            FriendsDAO.findUser(self.currentFriend!, ch: { (object, success) -> Void in
                if success{
                    self.updateData(object!)
                    self.friend = object 
                    
                    
                }else{
                    //error to download a friend
                }
            })
        }else{
            //erro de encontrar o usuario
        }
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addFriend(sender: AnyObject) {
        self.addOrAcceptFriend()
        
    }
    @IBAction func recuseFriend(sender: AnyObject) {
        //self.recuseFriend()
    }

}

//Parse
extension FriendProfileVC {

   
    func addOrAcceptFriend(){
        
        
    FriendsDAO.friendReques(self.friend, currentRequest: self.currentRequest) { (success) -> Void in
        if success{
            
            self.addButton.hidden = true
            self.delegate?.addIdFriend(self.currentFriend!)
            print("pedido feito")
        }else{
            print("error")
        }
        
        }
    
        
    }
}

extension FriendProfileVC {
    func updateData(friend:PFObject){
        print(friend)
        self.friendName.text = (friend.valueForKey("name") as! String)
    }

}