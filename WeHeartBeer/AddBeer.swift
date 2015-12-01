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
        @IBOutlet weak var abv: UITextField!
        @IBOutlet weak var style: UITextField!
        
        @IBOutlet weak var ibu: UITextField!
        
        var pickOptionParse:[PFObject]? = [PFObject]()
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            var pickerView = UIPickerView()
            self.queryParse()
            pickerView.delegate = self
            
            style.inputView = pickerView
        }
        
        
        @IBAction func saveObject(sender: AnyObject) {
            if self.nameBeer.text != ""{
                    if self.abv.text != ""{
                        if self.style.text != ""{
                            print("Salvar")
                            
                        }else{
                            self.alertForUser("Digite o estilo!")
                        }
                        
                    }else{
                        self.alertForUser("Digite o ABV!")
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
        
        
        func queryParse(){
            let query = PFQuery(className:"Style")
            query.findObjectsInBackgroundWithBlock {(result:[PFObject]?, error:NSError?) -> Void in
                if error == nil {
                    if let result = result as [PFObject]? {
                        print(result)
                        self.pickOptionParse = result
                        
                    
                    }else{
                        print("erro dao")
                        //completionHandler(beer:nil,success: false)
                    }
                }else{
                    print("erro dao 2")
                    //completionHandler(beer:nil,success: false)
                }
                
                
                
            }
        }
        func saveInParse(){
            
            
            
        }
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    }
    
   extension AddBeer:UIPickerViewDataSource, UIPickerViewDelegate {
    
   //Set number of components in picker view
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Set number of rows in components
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOptionParse!.count
    }
    
    //Set title for each row
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //cell.beersFromBrew?.text = self.beers[indexPath.row].objectForKey("name") as? String
        print(self.pickOptionParse![row].objectForKey("name"))
        return self.pickOptionParse![row].objectForKey("name") as? String
//        return pickOption[row]
    }
    
    //Update textfield text when row is selected
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        style.text = self.pickOptionParse![row].objectForKey("name") as? String
       // style.text = pickOption[row]
        //hides the pickview
        style.resignFirstResponder()

    }
    
    
    }
