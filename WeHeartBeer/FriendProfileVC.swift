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
    var friend:User?
    
    
    override func viewDidLoad() {
       
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //self.loadUser()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addFriend(sender: AnyObject) {
        //self.addOrAcceptFriend()
        
    }
    @IBAction func recuseFriend(sender: AnyObject) {
        //self.recuseFriend()
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

//Parse
extension FriendProfileVC {
    
    
//    @NSManaged var name: String
//    @NSManaged var birthDate: NSDate
//    @NSManaged var photo: PFFile
//    @NSManaged var mail: String
//    @NSManaged var faceID: String
//    @NSManaged var frieds: PFRelation!

    func loadUser() {
        if self.currentFriend != nil {
            let query = PFQuery(className: "_User")
            query.whereKey("faceID", equalTo: self.currentFriend!)
            query.getFirstObjectInBackgroundWithBlock({ (obj: PFObject?, error: NSError?) -> Void in
                if error == nil{
                    if obj != nil{
                        
                        self.friend?.name = (obj?.valueForKey("name") as! String)
                        self.friend?.photo = (obj!.valueForKey("photo") as! PFFile)
                        self.friend?.faceID = self.currentFriend!
                        
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
//
//    
//    func addOrAcceptFriend(){
//    
//        
//    }
//    
//    func recuseFriend(){
//        
//    }
//    
//    
}