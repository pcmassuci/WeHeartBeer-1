//
//  ChallengeDao.swift
//  BeerLove
//
//  Created by Paulo César Morandi Massuci on 02/02/16.
//  Copyright © 2016 Fernando H M Bastos. All rights reserved.
//

import Foundation


class ChallengeDAO{
    typealias FindObjectCompletionHandler = (challenge:PFObject?,success:Bool) -> Void

    
    
    static func getChallengeforParse(ch:FindObjectCompletionHandler){
        let query = PFQuery(className: "Challenge")
        query.whereKey("verify", equalTo: true)
        query.getFirstObjectInBackgroundWithBlock { (chal, error) -> Void in
            if error == nil{
                ch(challenge:chal!, success: true)
            }else{
                print("error: \(error)")
                ch(challenge: nil, success: false)
            }
        }
        
    }
}
