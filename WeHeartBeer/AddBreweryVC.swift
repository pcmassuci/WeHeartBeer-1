//
//  AddBreweryVC.swift
//  BeerLove
//
//  Created by Paulo César Morandi Massuci on 04/12/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import UIKit

class AddBreweryVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
   // @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var contactTex: UITextField!
    @IBOutlet weak var addressText: UITextField!
    @IBOutlet weak var countryBut: UIButton!
    var country:String? = ""
    var textFieldHeightSize = 0.0 as CGFloat
     var dictBrew = [String:String?]()
    
    override func viewDidLoad() {
       super.viewDidLoad()
        
        self.navigationController?.navigationBar.hidden = true
        self.nameTextField.delegate = self
        self.addressText.delegate = self
        //self.countryTextField.delegate = self
        self.contactTex.delegate = self
        self.addressText.delegate = self
        var countries: [String] = []
        
        for code in NSLocale.ISOCountryCodes() as [String] {
            let id = NSLocale.localeIdentifierFromComponents([NSLocaleCountryCode: code])
            let name = NSLocale(localeIdentifier: "pt_BR").displayNameForKey(NSLocaleIdentifier, value: id) ?? "Country not found for code: \(code)"
            countries.append(name)
        }
        
      
        let screenHeight = UIScreen.mainScreen().bounds.height
        print(screenHeight)
        
        switch screenHeight {
        case 480:
            
            self.introLabel.font = UIFont(name: "Lato", size: 0)
            self.nameLabel.font = UIFont(name: "Lato", size: 13)
            self.addressLabel.font = UIFont(name: "Lato", size: 13)
            self.countryLabel.font = UIFont(name: "Lato", size: 13)
            self.linkLabel.font = UIFont(name: "Lato", size: 13)

        default: // rest of screen sizes
            break
        }

        

        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: self.view.window)
        
        let bounds = UIScreen.mainScreen().bounds
        let width = bounds.size.width
        let height = bounds.size.height
        

        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = true

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: self.view.window)
    }
    func textFieldDidBeginEditing(textField: UITextField) {
      self.textFieldHeightSize =  textField.frame.origin.y
        
        
        //var x = textField.frame.origin.x;
        
        //NSLog("x Position is :%f , y position is : %f",x,y);
    }
    
    
    @IBAction func saveObject(sender: AnyObject) {
        
        if self.nameTextField.text != ""{
            if self.country != ""{
               
                
    
                BreweryDAO.checkBrewery(self.nameTextField.text!, ch: { (exist, success) -> Void in
                    if success{
                        if exist{
                        self.alert("Atenção", message: "Cervejaria já cadastrada em nosso banco de dados", option: false, action: nil)
                        }else{
                            
                            
                            
                            
                            
                            self.dictBrew["name"] = self.nameTextField.text
                            self.dictBrew["country"] = self.country
                            self.dictBrew["contact"] = self.contactTex.text
                            self.dictBrew["address"] = self.addressText.text
                            self.performSegueWithIdentifier("addBrewToAddBeer", sender:nil)
                            
                
                        }
                    }
            
                })
                    }else{
                self.alertForUser("Digite o País de origem")
            }
            
        }else{
            self.alertForUser("Digite o nome da cervejaria")
        }
        
        //////////////////
//        if self.nameTextField.text != ""{
//            if self.country != ""{
//                    self.dictBrew["name"] = self.nameTextField.text
//                    self.dictBrew["country"] = self.country
//                    self.dictBrew["contact"] = self.contactTex.text
//                
//                    BreweryServices.saveNewBrewery(self.nameTextField.text, local: self.country, contact: self.contactTex.text, address: self.addressText.text!, completionHandler: { (mensage, success) -> Void in
//                    
//                        if success{
//                            let query = PFQuery(className:"Brewery")
//                            query.whereKey("name", equalTo:self.nameTextField.text!)
//                            query.findObjectsInBackgroundWithBlock {
//                                (objects: [PFObject]?, error: NSError?) -> Void in
//                                
//                                if error == nil {
//                                    // The find succeeded.
//                                    print("Successfully retrieved \(objects!.count) scores.")
//                                    // Do something with the found objects
//                                    if let objects = objects {
//                                        for object in objects {
//                                            print(object.objectId)
//                                        self.performSegueWithIdentifier("addBrewToAddBeer", sender:object)
//                                            
//                                        }
//                                    }
//                                } else {
//                                    // Log details of the failure
//                                    print("Error: \(error!) \(error!.userInfo)")
//                                }
//                            }
//                       
//                        }else{
//                            self.alertForUser(mensage)
//                        }
//                    })
//                
//                }else{
//                    self.alertForUser("Digite o País de origem")
//                }
//                
//            }else{
//                self.alertForUser("Digite o nome da cervejaria")
//            }
//            
        
    }

   

    @IBAction func cancelButton(sender: AnyObject) {
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    // MARK: - Navigation
    //MARK: -Prepare segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addBrewToAddBeer"{
            if let destination = segue.destinationViewController  as?  AddBeer  {
               destination.breweryDict = self.dictBrew
                
                }
            }
        if segue.identifier == "segueCountry"{
            if let destination = segue.destinationViewController as? CountriesSearch {
                destination.delegate = self
                
            }
            
        }
}
}

//MARK: - KEYBOARDS METHODS
extension AddBreweryVC{
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
        
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func keyboardWillHide(sender: NSNotification) {
      
        self.view.frame.origin.y = 0
            
    }
    func keyboardWillShow(sender: NSNotification) {
        let userInfo: [NSObject : AnyObject] = sender.userInfo!
        
        let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
        let offset: CGSize = userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue.size
        
        
        let bounds = UIScreen.mainScreen().bounds
        let height = bounds.size.height
            
        if (height - keyboardSize.height) <= self.textFieldHeightSize {
    
        if keyboardSize.height == offset.height {
            if self.view.frame.origin.y == 0 {
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.view.frame.origin.y -= keyboardSize.height - 60
                })
            }
        } else {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.view.frame.origin.y = keyboardSize.height - offset.height - 60
            })
        }
        print(self.view.frame.origin.y)        }
    }
}



//MARK: - ALERT

extension AddBreweryVC{
    
    func alertForUser(message:String){
        let alert = UIAlertController(title: "Atenção", message:message, preferredStyle:UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
   
}

extension AddBreweryVC: CountriesSearchDelegate {
    
    @IBAction func countryList(sender: AnyObject) {
        performSegueWithIdentifier("segueCountry", sender: nil)
    }
    
    func country(nameCountry:String?){
        self.countryBut.setTitle(nameCountry, forState: UIControlState.Normal)
         self.country = nameCountry
        }
    
}
