//
//  UIViewController+Actions.swift
//  BeerLove
//
//  Created by Paulo César Morandi Massuci on 28/01/16.
//  Copyright © 2016 Fernando H M Bastos. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func navigationCollor(){
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 250.0/255.0, green: 170.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    }
    
    func changeColor(){
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 250.0/255.0, green: 170.0/255.0, blue: 0.0/255.0, alpha: 1.0)

        
    }

    func internetCheck() -> Bool{
        if Reachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
            return true 
        } else {
            print("Internet connection FAILED")
            
            self.alert("Sem Internet!!", message: "Verifique se seu aparelho possui uma conexão com a internet", option: false, action: nil)
            return false
        }
        
    }
    
    func alert(title:String, message:String,option:Bool, action: AnyObject?){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        
        if option{
            let cancelAction = UIAlertAction(title: "Cancelar", style: .Cancel) { (action:UIAlertAction!) in
                print("you have pressed the Cancel button");
            }
            alertController.addAction(cancelAction)
            
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action:UIAlertAction!) in
                print("you have pressed OK button");
            }
            alertController.addAction(OKAction)
            
        }else{   let cancelAction = UIAlertAction(title: "Ok", style: .Cancel) { (action:UIAlertAction!) in
            print("you have pressed the Cancel button");
            }
            alertController.addAction(cancelAction)
            
        }
        
        
     
        
        self.presentViewController(alertController, animated: true, completion:nil)

        
    }
    func loadView{
        
    }
    
}
