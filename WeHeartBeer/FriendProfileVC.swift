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
    var friends = [String:PFObject?]()
    
   
    @IBOutlet weak var tip: UILabel!
    
    override func viewDidLoad() {
       super.viewDidLoad()
        self.internetCheck()
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: Selector("beersTapped:"))
        let tapGesture2 = UITapGestureRecognizer(target: self, action: Selector("friendsTapped:"))
        self.beerIcone.userInteractionEnabled = true
        self.beerIcone.addGestureRecognizer(tapGesture1)
        self.friendsIcone.userInteractionEnabled  = true
        self.friendsIcone.addGestureRecognizer(tapGesture2)
   
}



    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.tintBarUp(self.view)
        profileImage.layer.borderWidth = 1
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.blackColor().CGColor
        profileImage.clipsToBounds = true
        
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        
        addButton.layer.masksToBounds = false
        
        addButton.clipsToBounds = true
        
        addButton.layer.cornerRadius = addButton.frame.height/5
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.friends.removeAll()
        if self.currentFriend != nil{
 //Request to server Frienduser data
        
            FriendsDAO.findUser(self.currentFriend!, ch: { (object, success) -> Void in
                if success{
                    self.updateData(object!)
                    self.friend = object 
                    //chamar
                    self.checkFriend()
                    self.countFriends()
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
        self.addButton.hidden = true
        
    }
    @IBAction func recuseFriend(sender: AnyObject) {
        //self.recuseFriend()
    }

}

//Parse
extension FriendProfileVC {

   
    func addOrAcceptFriend(){
        
        if self.kindOfFriend == nil {
    FriendsDAO.friendReques(self.friend, currentRequest: self.currentRequest) { (success) -> Void in
        if success{
            
            self.addButton.hidden = true
            self.delegate?.addIdFriend(self.currentFriend!)
        
        }else{

        }
        
        }
        } else {
            self.kindOfFriend?.setValue(true, forKey: "accepted")
            self.kindOfFriend?.saveInBackground()
            
        }
        
        
    }
}

extension FriendProfileVC {
    
    func checkFriend(){
        let user1 = User.currentUser()
        let user2 = self.friend
        FriendsDAO.friendQuery(user1!, user2: user2!, check: true, ch: { (object, success) -> Void in
            if success{
                self.kindOfFriend = object
                let user = user1?.faceID
                let id = object?.objectForKey("id1") as! String?
                if id == user{
                    self.addButton.setTitle("", forState: .Normal)
                    self.addButton.hidden = true
                    
                }else{
                     self.addButton.setTitle("Aceitar", forState: .Normal)
                
                }
                
                
            }else{
              
                self.addButton.hidden = false
                self.addButton.setTitle("Adicionar", forState: .Normal)
            }
        })

    }
    
    func countFriends(){
        FriendsDAO.friendsQuery(self.friend!) { (object, success) -> Void in
            if success{
                if object != nil{
                    self.numberOfFriends.text = ("\(object!.count)")
                for o in object! {
                    
                    let id = o.objectForKey("id1") as! String
                    let us = self.friend?.objectForKey("faceID") as! String
                    let name1 = o.objectForKey("name1") as! String
                    let name2 = o.objectForKey("name2") as! String
                    print(id)
                    print(us)

                    if id == us{
                        self.friends[name2] = (o.objectForKey("user2") as! PFObject?)
                      
                    }else {
                        self.friends[name1] = (o.objectForKey("user1") as! PFObject?)

                    }
                    
                    
                }
                   
                }else{
                    self.numberOfFriends.text = "0"
                }
                
            }else{
                self.numberOfFriends.text = "0"
            }
        }
    }
    
    
 //MARK:- Navegation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "friendToFriend") {
            if let destination = segue.destinationViewController  as? FriendsFromMyFriends{
                destination.currentFriends = self.friends
                destination.delegate = self
            }
            
            
        }
        if (segue.identifier == "segueToFriendsBeers") {
            if let destination = segue.destinationViewController  as? ReviewBeerFriendViewController{
                print(self.friend)
                destination.user  = self.friend
            }
            
        }
    }

        

    
    
    
    
    func beersTapped(img:AnyObject){
        print("to: \(self.friend)")
        self.performSegueWithIdentifier("segueToFriendsBeers", sender: nil)
    }
    
    func friendsTapped(img:AnyObject){
        self.performSegueWithIdentifier("friendToFriend", sender: nil)
    }

    
    func updateData(friend:PFObject){
        countBeers(friend)
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

    func countBeers(friend:PFObject?){
            ReviewDAO.findReviewFromUser(friend!) { (reviews, success) -> Void in
            self.numberOfBeers.text = String((reviews?.count)! as NSNumber)
        }

    }
    
    
}

extension FriendProfileVC: FriendListVCDelegate{
    func newFriend(friendOb:PFObject) {
        print(friendOb)
        self.friend = friendOb
        self.updateData(self.friend!)
        self.currentFriend = (self.friend!.objectForKey("faceID") as! String)
    }
    
    
}
