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
    
    typealias FindObjectsCompletionHandler = (requests:[Friends]?, waitingFriends:[Friends]?, myFriends:[Friends]? ,success:Bool) -> Void
    
    
    static func queryFriends(completionHandler:FindObjectsCompletionHandler) {
        print("entrou no dao")
        var requests:[Friends]? = [Friends]()
        var myFriends: [Friends]? = [Friends]()
        var waitingFriends:[Friends]? = [Friends]()

        
        
        let user = User.currentUser()
        let query = PFQuery(className: "Friends")
        query.whereKey("id1", equalTo: (user?.faceID)!)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) f1 scores.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        print(object.objectId)
                        if object.valueForKey("accepted") != nil{
                            if object.valueForKey("accepted") as? Bool  == false {
                                waitingFriends?.append(object as! Friends)
                                
                            }else{
                                requests?.append(object as! Friends)
                            }
                        }
                        
                    }
                    let qry = PFQuery(className: "Friends")
                    qry.whereKey("id2", equalTo: (user?.faceID)!)
                    qry.findObjectsInBackgroundWithBlock({ (objs:[PFObject]?, erro: NSError?) -> Void in
                        if erro == nil{
                            if let objs = objs{
                                for obj in objs{
                                    
                                    print(obj.objectId)
                                    if obj.valueForKey("accepted") != nil{
                                        if obj.valueForKey("accepted") as! Bool  == false {
                                            requests?.append(obj as! Friends)
                                            
                                        }else{
                                            myFriends?.append(obj as! Friends)
                                        }
                                    }
                                }
                            }
                            
                        }else{
                            print("Error: \(error!) \(error!.userInfo)")
                            completionHandler(requests: nil, waitingFriends: nil, myFriends: nil, success: false)
                        }
                    })
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
                completionHandler(requests: nil, waitingFriends: nil, myFriends: nil, success: false)
            }
          
        }
        completionHandler(requests: requests, waitingFriends: waitingFriends, myFriends: myFriends, success: true)
    
        
    }

    
    
    
    
    
    
    
    
    
}