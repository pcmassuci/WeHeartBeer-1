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
    
    @IBOutlet weak var friendsIcone: UIImageView!
    @IBOutlet weak var beerIcone: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
  //labels
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var numberOfBeers: UILabel!
    @IBOutlet weak var numberOfFriends: UILabel!
    
    var kindOfFriend:PFObject?
    var friend: PFObject?
    var currentRequest: PFObject?
    var currentFriend: String? = ""
    var choice:Int?
   
    
   
    @IBOutlet weak var tip: UILabel!
    
    override func viewDidLoad() {
       super.viewDidLoad()
        self.internetCheck()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if self.currentFriend != nil{
 //Request to server Frienduser data
            FriendsDAO.findUser(self.currentFriend!, ch: { (object, success) -> Void in
                if success{
                    
                    
                    self.updateData(object!)
                    self.friend = object 
                    //chamar
                    self.checkFriend()
                    
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
    
    func checkFriend(){
        let user1 = User.currentUser()
        let user2 = self.friend
        FriendsDAO.friendQuery(user1!, user2: user2!, check: true, ch: { (object, success) -> Void in
            if success{
                print("leia")
                self.kindOfFriend = object
                let user = user1?.faceID
                let id = object?.objectForKey("id1") as! String?
                if id == user{
                    self.addButton.setTitle("", forState: .Normal)
                    self.addButton.hidden = true
                    
                }else{
                    print("solo")
                     self.addButton.setTitle("Aceitar", forState: .Normal)
                
                }
                
                
            }else{
              
                self.addButton.hidden = false
                self.addButton.setTitle("Adicionar", forState: .Normal)
            }
        })

    }
    
    func updateData(friend:PFObject){
        print(friend)
        self.friendName.text = (friend.valueForKey("name") as! String)
        let pfImage = friend.objectForKey("photo") as? PFFile
        ImageDAO.getImageFromParse(pfImage) { (image, success) -> Void in
            if success{
                self.profileImage.image = image
                
            }else{
                ///colocar imagem random
                
            }
        }
    }

}