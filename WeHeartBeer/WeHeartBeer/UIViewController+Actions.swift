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
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func changeColor(){
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 250.0/255.0, green: 170.0/255.0, blue: 0.0/255.0, alpha: 1.0)

        
    }
    
    func tintBarUp (view: UIView) -> Void{
        
        let view2 = UIView(frame:
            CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: UIApplication.shared.statusBarFrame.size.height)
        )
        view2.backgroundColor = UIColor(red: 250.0/255.0, green: 170.0/255.0, blue: 4.0/255.0, alpha: 1.0)
        
        view.addSubview(view2)
        
    }


    func internetCheck() -> Bool{
        if Reachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
            return true 
        } else {
            print("Internet connection FAILED")
            
            self.alert(title: "Sem Internet!!", message: "Verifique se seu aparelho possui uma conexão com a internet", option: false, action: nil)
            return false
        }
        
    }
    
    func alert(title:String, message:String,option:Bool, action: AnyObject?){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        if option{
            let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) { (action:UIAlertAction!) in
                print("you have pressed the Cancel button");
            }
            alertController.addAction(cancelAction)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                print("you have pressed OK button");
            }
            alertController.addAction(OKAction)
            
        }else{   let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action:UIAlertAction!) in
            print("you have pressed the Cancel button");
            }
            alertController.addAction(cancelAction)
            
        }
     
        
        self.present(alertController, animated: true, completion:nil)

        
    }
    
        func loadingView(){
        
    }
    
}
