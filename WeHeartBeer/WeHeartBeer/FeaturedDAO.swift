//
//  FeaturedDAO.swift
//  BeerLove
//
//  Created by Júlio César Garavelli on 28/01/16.
//  Copyright © 2016 Fernando H M Bastos. All rights reserved.
//

import Foundation
import UIKit

class FeaturedDAO{
    
    typealias FindObjectsCompletionHandler = (objs:[PFObject]?,success:Bool) -> Void
    typealias FindBrsAndImgCompletionHandler = (dict:[PFObject:UIImage],array:[PFObject] ,success: Bool) -> Void
    
    
private static func queryFeatured(ch:FindObjectsCompletionHandler){
        let query = PFQuery(className:"Featured")
        query.whereKey("active", equalTo: true)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Sucesso ao recuperar \(objects!.count) pontuação.")
                ch(objs: objects, success: true)

            } else {
                ch(objs: nil, success: false)
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }

        
    }
    



    static func getDictBeerAndImage(ch:FindBrsAndImgCompletionHandler){
        var dict = [PFObject:UIImage]()
        var feat = [PFObject]()
        var j = 0
        self.queryFeatured { (objs, success) -> Void in
            if success {
                let i = objs?.count
                for obj in objs!{
                    let be = obj.objectForKey("beer") as! PFObject
                    let id = be.objectId!
                    //print(id)
                    BeerDAO.queryBeerFromObjectID(id, ch: { (beer, success) -> Void in
                        if success{
                            let bimg = beer?.objectForKey("Photo") as? PFFile
                            if bimg != nil {
                                ImageDAO.getImageFromParse(bimg, ch: { (image, success) -> Void in
                                    if success{
                                        let sbeer = beer!
                                        //print(sbeer)
                                        feat.append(sbeer)
                                        dict[sbeer] = image
                                        j += 1
                                        if j == i {
                                         print(dict)
                                            ch(dict: dict, array: feat, success: true)
                                        }
                                        
                                        
                                    }else{
                                        print("Erro ao pegar Imagem")
                                    }
                                })
                                
                            }else{
                                print("sem imagem")
                            }
                            
                        }else{
                            print("nao conseguiu pegar a beer")
                        }
                    })
//
                }
//               
//                ch(dict: dict, success: true)
            }else{
                    print("Nao pegou o challenge")
                ch(dict: dict, array: feat, success: false)
                }
            
            
        }
    }
    
                    
                    
                    
    
    


}


