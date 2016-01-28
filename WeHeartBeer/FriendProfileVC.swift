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
        self.internetCheck()
        
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
        
    FriendsDAO.friendReques(self.friend, currentRequest: self.currentRequest) { (success) -> Void in
        if success{
            print("pedido feito")
        }else{
            print("error")
        }
        
        }
    
        
    }
}

extension FriendProfileVC {
    func updateData(){
        self.friendName.text = (self.friend!.valueForKey("name") as! String)
    }

}