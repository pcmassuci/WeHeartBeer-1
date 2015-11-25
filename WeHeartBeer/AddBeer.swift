    //
    //  AddBeer.swift
    //  WeHeartBeer
    //
    //  Created by Fernando H M Bastos on 11/19/15.
    //  Copyright © 2015 Fernando H M Bastos. All rights reserved.
    //
    
    import UIKit
    import Parse
    import ParseUI
    
    class AddBeer: UIViewController {
        
        @IBOutlet weak var nameBeer: UITextField!
        @IBOutlet weak var nameBrewery: UITextField!
        @IBOutlet weak var abv: UITextField!
        @IBOutlet weak var style: UITextField!
        
        
        
        
        override func viewDidLoad() {
            super.viewDidLoad()          
        }
        
        
        @IBAction func saveObject(sender: AnyObject) {
            if self.nameBeer.text != ""{
                if self.nameBrewery.text != ""{
                    if self.abv.text != ""{
                        if self.style.text != ""{
                            print("Salvar")
                            
                        }else{
                            print("Digite o estilo!")
                        }
                        
                        
                    }else{
                        print("Digite o ABV!")
                    }
                    
                }else{
                    print("Digite o nome da cervejaria!")
                }
                
            }else{
                self.alertForUser("Digite o nome da cerveja!")
            }
            
        }
        
        
        func alertForUser(message:String){
            let alert = UIAlertController(title: "Atenção", message:message, preferredStyle:UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
    }
