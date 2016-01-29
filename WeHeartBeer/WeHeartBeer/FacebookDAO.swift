//
//  FacebookDAO.swift
//  BeerLove
//
//  Created by Paulo César Morandi Massuci on 23/01/16.
//  Copyright © 2016 Fernando H M Bastos. All rights reserved.
//

import Foundation


class FacebookDAO{
    
    
    func getFBAppFriends(nextCursor : String?, failureHandler: (error: NSError) -> Void) {
//        
        var obj:[String] = [String]()
        var objID:[String] = [String]()
//        var objDict = [String:Int]()
        
        let qry = "/me/friends"
        var parameters = Dictionary<String, String>() as? Dictionary
        if nextCursor == nil {
            parameters = nil
        } else {
            parameters!["after"] = nextCursor
        }
        
        let request = FBSDKGraphRequest(graphPath: qry, parameters: parameters);
        
        
        request.startWithCompletionHandler { (connection : FBSDKGraphRequestConnection!, result : AnyObject!, error : NSError!) -> Void in
            
            if (error) != nil{
                // Process error
                print("Error: \(error)")
                
            }else{
                //println("fetched user: \(result)")
                let resultdict = result as! NSDictionary
                let data : NSArray = resultdict.objectForKey("data") as! NSArray
                
                for i in 0..<data.count {
                    let valueDict : NSDictionary = data[i] as! NSDictionary
                    let id = valueDict.objectForKey("id") as! String
                    let name = valueDict.objectForKey("name") as! String
                    
                    objID.append(id)
                    obj.append(name)
                    
                }
                if let after = ((resultdict.objectForKey("paging") as? NSDictionary)?.objectForKey("cursors") as? NSDictionary)?.objectForKey("after") as? String {
                    self.getFBAppFriends(after, failureHandler: {(error) in
                        print("error")})
                } else {
                    print("Can't read next!!!")
            
                    
                }
            }
            
        }

        
    }
    
  func shareOnFacebook(){
    
    
    }
    
}
