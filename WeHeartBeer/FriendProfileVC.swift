//
//  FriendProfileVC.swift
//  BeerLove
//
//  Created by Paulo César Morandi Massuci on 18/01/16.
//  Copyright © 2016 Fernando H M Bastos. All rights reserved.
//

import UIKit

class FriendProfileVC: UIViewController {

    @IBOutlet weak var friendName: UILabel!
    var currentRequest: PFObject?
    var currentFriend: String?
   // var check: Bool
    var friend: PFObject?
    
    
    override func viewDidLoad() {
       
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.loadUser()
        
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

    func loadUser() {
        if self.currentFriend != nil {
            let query = PFQuery(className: "_User")
            query.whereKey("faceID", equalTo: self.currentFriend!)
            query.getFirstObjectInBackgroundWithBlock({ (obj: PFObject?, error: NSError?) -> Void in
                if error == nil{
                    if obj != nil{
                        print(obj)
                    self.friend  = obj!
                    self.updateData()
                        
                        print(self.friend)
                    } else {
                        print("erro Usuario não encontrado")
                    }
                    
                }else{
                    print("erro ao baixar usuário")
                }
            })
            
        }else{
            print("ERRO AO PASSAR USUÁRIO")
        }
        
    }
   
    func addOrAcceptFriend(){
        print(currentRequest)
        
        if currentRequest == nil {
            let user = User.currentUser()
            let friendList = PFObject(className:"Friends")
            friendList["user1"] = user
            friendList["name1"] = user?.name
            friendList["id1"] = user?.faceID
            friendList["accepted"] = false
            friendList["user2"] = self.friend!
            friendList["name2"] = self.friend!.objectForKey("name")
            friendList["id2"] = self.friend?.valueForKey("faceID")
            friendList.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    print("PEDIDO deu Certo")
                    // The object has been saved.
                } else {
                    print("PEDIDO DEU ERRADO")
                    // There was a problem, check error.description
                }
            }
            
        }
    
        
    }
}

extension FriendProfileVC {
    func updateData(){
        self.friendName.text = (self.friend!.valueForKey("name") as! String)
    }
}