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
    typealias FindBrsAndImgCompletionHandler = (dict:[Int:[PFObject:UIImage]],array:[PFObject] ,success: Bool) -> Void
    typealias FindFeaturesCompletionHandler = (dict:[PFObject:UIImage?]?,success:Bool) -> Void
    
    
static func queryFeatured(ch:FindObjectsCompletionHandler){
        let query = PFQuery(className:"Featured")
        query.whereKey("active", equalTo: true)
        query.orderByAscending("order")
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
    

    static func getDicFeaturesAndImages(ch:FindFeaturesCompletionHandler ){
        
        self.queryFeatured { (objs, success) -> Void in
            if success{
                
                var dict = [PFObject:UIImage?]()
                let i = objs?.count
                var j = 0
                for obj in objs!{
                
                    let fImage = obj.objectForKey("photo") as! PFFile
                    ImageDAO.getImageFromParse(fImage, ch: { (image, success) -> Void in
                        if success{
                            
                            dict[obj] = image
                            j += 1
                            if j == i{
                                ch(dict: dict, success: true)
                            }
                            
                        }else{
//                            erro ao pegar imagem
                        }
                    })
                }
                
            }else{
                ch(dict: nil, success: false)
                ///nao pegou as features
            }
        }
        
    }


    static func getDictBeerAndImage(ch:FindBrsAndImgCompletionHandler){
        var dict = [PFObject:UIImage]()
        var dictFinal = [Int:[PFObject:UIImage]]()
        var feat = [PFObject]()
        var j = 0
        self.queryFeatured { (objs, success) -> Void in
            if success{
                let i = objs?.count
                for obj in objs!{
                    let be = obj.objectForKey("beer") as! PFObject
                    let id = be.objectId!
                    BeerDAO.queryBeerFromObjectID(id, ch: { (beer, success) -> Void in
                        if success{
                            
                            //let bimg = beer?.objectForKey("Photo") as? PFFile
                            let bimg = obj.objectForKey("photo") as? PFFile
                            if bimg != nil {
                                ImageDAO.getImageFromParse(bimg, ch: { (image, success) -> Void in
                                    if success{
                                        let sbeer = beer!
                                        //print(sbeer)
                                        feat.append(sbeer)
                                        dict[sbeer] = image
                                        j += 1
                                        if j == i {

                                            dictFinal = self.controlDict(objs!, dict: dict)
                                            ch(dict: dictFinal, array: feat, success: true)
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
                ch(dict: dictFinal, array: feat, success: false)
                }
            
            
        }
    }
    
static func controlDict(array:[PFObject],dict:[PFObject:UIImage]) -> [Int:[PFObject:UIImage]]
{
    var dictB = [Int:[PFObject:UIImage]]()
    
            for a in array{
            for (key, value) in dict{
                let controlA = key.objectId
                //print(controlA)
                let controlB = (a.objectForKey("beer")?.objectId)! as String
                //print(controlB)
                if controlA == controlB{
                    let x = a.objectForKey("order") as! Int
                    dictB[x] = [key:value]
                    
                }
            }
    }

    
    //print("maldito dict: \(dictB)")
    
    return dictB
    }
    
    
}

