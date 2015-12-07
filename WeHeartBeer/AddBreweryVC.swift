//
//  AddBreweryVC.swift
//  BeerLove
//
//  Created by Paulo César Morandi Massuci on 04/12/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import UIKit

class AddBreweryVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var contactTex: UITextField!
    @IBOutlet weak var addressText: UITextField!

    override func viewDidLoad() {
        
        self.navigationController?.navigationBar.hidden = true

        self.addressText.delegate = self
        self.countryTextField.delegate = self
        self.contactTex.delegate = self
        self.addressText.delegate = self
        
        
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: self.view.window)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: self.view.window)
    }
    
    
    @IBAction func saveObject(sender: AnyObject) {
        if self.nameTextField.text != ""{
            if self.countryTextField.text != ""{
                    
                    BreweryServices.saveNewBrewery(self.nameTextField.text, local: self.countryTextField.text, contact: self.contactTex.text, address: self.addressText.text!, completionHandler: { (success) -> Void in
                        if success{
                            let query = PFQuery(className:"Brewery")
                            query.whereKey("name", equalTo:self.nameTextField.text!)
                            query.findObjectsInBackgroundWithBlock {
                                (objects: [PFObject]?, error: NSError?) -> Void in
                                
                                if error == nil {
                                    // The find succeeded.
                                    print("Successfully retrieved \(objects!.count) scores.")
                                    // Do something with the found objects
                                    if let objects = objects {
                                        for object in objects {
                                            print(object.objectId)
                                        self.performSegueWithIdentifier("addBrewToAddBeer", sender:object)
                                            
                                        }
                                    }
                                } else {
                                    // Log details of the failure
                                    print("Error: \(error!) \(error!.userInfo)")
                                }
                            }
                           // self.alertForUser("Parabéns, cervejaria cadastrada com sucesso")
                            
                            
                            
                            //self.performSegueWithIdentifier("addBrewToAddBeer", sender: nil)
                        }else{
                            self.alertForUser("ERRO, CERVEJARIA NÃO CADASTRADA, tente novamente")
                        }
                    })
                
                }else{
                    self.alertForUser("Digite o País de origem")
                }
                
            }else{
                self.alertForUser("Digite o nome da cervejaria")
            }
            
        
    }

   

    @IBAction func cancelButton(sender: AnyObject) {
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    // MARK: - Navigation
    //MARK: -Prepare segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addBrewToAddBeer"{
            if let destination = segue.destinationViewController  as?  AddBeer  {
               destination.brewery = (sender) as? Brewery
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
        return false
    }
    
    func keyboardWillHide(sender: NSNotification) {
        let userInfo: [NSObject : AnyObject] = sender.userInfo!
        let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
        self.view.frame.origin.y += keyboardSize.height
    }
    func keyboardWillShow(sender: NSNotification) {
        let userInfo: [NSObject : AnyObject] = sender.userInfo!
        
        let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
        let offset: CGSize = userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue.size
        
        if keyboardSize.height == offset.height {
            if self.view.frame.origin.y == 0 {
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.view.frame.origin.y -= keyboardSize.height
                })
            }
        } else {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.view.frame.origin.y += keyboardSize.height - offset.height
            })
        }
        print(self.view.frame.origin.y)        }
    
}
//

//MARK: - ALERT

extension AddBreweryVC{
    
    func alertForUser(message:String){
        let alert = UIAlertController(title: "Atenção", message:message, preferredStyle:UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
}
