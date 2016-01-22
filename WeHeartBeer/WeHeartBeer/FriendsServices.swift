//
//  FriendsServices.swift
//  BeerLove
//
//  Created by Paulo César Morandi Massuci on 20/01/16.
//  Copyright © 2016 Fernando H M Bastos. All rights reserved.
//


import UIKit
import Foundation
import Parse

class FriendsServices {
    
    typealias FindObjectsCompletionHandler = (requests:[Friends]?, waitingFriends:[Friends]?, myFriends:[Friends]? ,success:Bool) -> Void
//    
//   static func requestFriendList(completionHandler:FindObjectsCompletionHandler){
//        FriendsDAO.queryFriends { (requests, waitingFriends, myFriends, success) -> Void in
//            if success{
//                completionHandler(requests: requests, waitingFriends: waitingFriends, myFriends: myFriends, success: true)
//            }else{
//               completionHandler(requests: requests, waitingFriends: waitingFriends, myFriends: myFriends, success: true)
//            }
//            
//        }
//        
//    }
//    
}
