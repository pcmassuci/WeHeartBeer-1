//
//  FriendsDAO.swift
//  BeerLove
//
//  Created by Paulo César Morandi Massuci on 20/01/16.
//  Copyright © 2016 Fernando H M Bastos. All rights reserved.
//

import UIKit
import Foundation
import Parse

class FriendsDAO {
    
    typealias FindObjectsCompletionHandler = (requests:[PFObject]?, waitingFriends:[PFObject]?, myFriends:[PFObject]? ,success:Bool) -> Void
    
    typealias FindObjsCH = (object:[PFObject]?, result:[PFObject]? , success: Bool) -> Void
    
    
    static func queryFriend(ch:FindObjsCH){
        let user = User.currentUser()
        let query = PFQuery(className: "Friends")
        query.whereKey("id1", equalTo: (user?.faceID)!)
        //query.whereKey("id2", equalTo: (user?.faceID)!)
        query.findObjectsInBackgroundWithBlock { (object:[PFObject]?, error: NSError?) -> Void in
            if error == nil{
            //ch(object: object, success:true)
            }else{
               // ch(object: nil, success: false)
                print(error)
            }
        }
        let qry = PFQuery(className: "Friends")
        qry.whereKey("id2", equalTo: (user?.faceID)!)
        qry.findObjectsInBackgroundWithBlock { (result: [PFObject]?, erro: NSError?) -> Void in
            if erro == nil{
                
            }else{
                //retornar ch
                
            }
        }
    }
    

    
    
    static func queryFriends(completionHandler:FindObjectsCompletionHandler) {
        print("entrou no dao")
        var verify1:Bool = false
        var verify2:Bool = false
        var verify3 = false
        var requests:[PFObject]? = [PFObject]()
        var myFriends: [PFObject]? = [PFObject]()
        var waitingFriends:[PFObject]? = [PFObject]()
        let user = User.currentUser()
        let query = PFQuery(className: "Friends")
        query.whereKey("id1", equalTo: (user?.faceID)!)
        let qry = PFQuery(className: "Friends")
        qry.whereKey("id2", equalTo: (user?.faceID)!)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) f1 scores.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                       // print(object.objectId)
                        if object.valueForKey("accepted") != nil{
                            if object.valueForKey("accepted") as? Bool  == false {
                                waitingFriends?.append(object)
                            }else{
                                myFriends?.append(object)
                            }
                            verify1 = true
                            if verify1 == true && verify2 == true && verify3 == false {
                                verify3 = true
                                
                                //print(waitingFriends)
                                completionHandler(requests: requests, waitingFriends: waitingFriends, myFriends: myFriends, success: true)
                            }
                        }else{
                            print("accepted nil")
                        }
                    }
                }
            }else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
                completionHandler(requests: nil, waitingFriends: nil, myFriends: nil, success: false)
            }//fim checagem de erro
        }//fim da query
        qry.findObjectsInBackgroundWithBlock({ (objs:[PFObject]?, erro: NSError?) -> Void in
            if erro == nil{
                if let objs = objs{
                    for obj in objs{
                       // print("teste")
                        //print(obj.objectId)
                        if obj.valueForKey("accepted") != nil{
                            if obj.valueForKey("accepted") as! Bool  == false {
                                requests?.append(obj)
                            }else{
                                print("0")
                                myFriends?.append(obj)
                            }
                        }
                    }
                    verify2 = true
                    if verify1 == true && verify2 == true && verify3 == false {
                        verify3 = true
                        completionHandler(requests: requests, waitingFriends: waitingFriends, myFriends: myFriends, success: true)
                    }
                }else{
                    print("Error: \(erro!) \(erro!.userInfo)")
                    completionHandler(requests: nil, waitingFriends: nil, myFriends: nil, success:
                        false)
                }
            }
        })
    
       
    
        
    }

    
    
    
    
    
    
    
    
}