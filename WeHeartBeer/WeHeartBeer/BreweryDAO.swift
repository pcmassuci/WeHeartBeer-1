//
//  BreweryDAO.swift
//  WeHeartBeer
//
//  Created by Paulo César Morandi Massuci on 09/11/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import UIKit
import Foundation
import Parse


class BreweryDAO {
    
    
    
    
    typealias createBreweryCH = (mensage:String, success:Bool)->Void
    typealias FindObjectsCompletionHandler = (brewery:[Brewery]?,success:Bool) -> Void
    typealias FindObjIDCompletionHandler = (brewery:Brewery?,success:Bool) -> Void
    typealias RegisterBeerCH = (success:Bool)->Void
    typealias CheckBrewery = (exist:Bool,success:Bool) -> Void
    
    static func createBrewery(name:String, contact:String?,local:String,address:String?, completionHandler: createBreweryCH){

        self.findBrewery(name) { (brewery, success) -> Void in
            print(brewery?.count)
            if brewery?.count > 0 {
                let userMensage = "Cervejaria já cadatrada"
                completionHandler(mensage: userMensage, success: false)
                
            }else{
                        print("nao Existe")
                        let newBrewery = PFObject(className:"Brewery")
                        newBrewery["contact"] = contact
                        newBrewery["name"] = name
                        newBrewery["local"] = local
                        newBrewery["address"] = address
                        newBrewery.saveInBackgroundWithBlock {
                            (success: Bool, error: NSError?) -> Void in
                            if (success) {
                                let userMensage = "Cervejaria cadatrada com sucesso"
                                completionHandler(mensage: userMensage, success: true)
                            } else {
                                let userMensage = "Cervejaria não cadatrada"
                                completionHandler(mensage: userMensage, success: false)                                // There was a problem, check error.description
                            }
                        }
                
            }
        }

    }
    

    
    
    //find Brewery, send a String Name from Parse
    
    
    static func findBrewery(brewery:String,completionHandler:FindObjectsCompletionHandler){
        
        let query = PFQuery(className: "Brewery")
        
        query.whereKey("name", equalTo: brewery)
        
        query.findObjectsInBackgroundWithBlock { (result:[PFObject]?, error:NSError?) -> Void in
            if error == nil {
                if let result = result as? [Brewery] {
                    completionHandler(brewery: result, success: true)
                }else{
                    print("erro dao")
                    completionHandler(brewery:nil,success: false)
                }
            }else{
                print("erro dao 2")
                completionHandler(brewery:nil,success: false)
            }
            
            
        }
        
    }
    static func findBreweryObjectID(objectID:String, completionHandler:FindObjIDCompletionHandler){
        let query = PFQuery(className:"Brewery")
        query.getObjectInBackgroundWithId(objectID) {(result:PFObject?, error:NSError?) -> Void in
            
            print(result)
            if let result = result{
                if let result = result as? Brewery {
                    //let result = result as? Brewery
                    print("fer")
                    print(result)
                    completionHandler(brewery: result, success: true)
                    //
                }
                else{
                    print("nando")
                    print(result)
                    completionHandler(brewery:nil,success: false)
                }
            }else{
                completionHandler(brewery:nil,success: false)
            }
            
            
            
            
            
            
        }
    }
    
    
static func checkBrewery(name:String, ch:CheckBrewery){
        let query = PFQuery(className:"Brewery")
        query.whereKey("name", equalTo:name)
        query.getFirstObjectInBackgroundWithBlock { (object, error) -> Void in
            if object == nil{
                ch(exist: false, success: true)
                
            }else{
                ch(exist: true, success: true)
            }
        }
    }
}