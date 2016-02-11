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
    
    class AddBeer: UIViewController, UITextFieldDelegate {
        
        //Labels
        @IBOutlet weak var nameBeer: UITextField!
        @IBOutlet weak var abv: UITextField!
        @IBOutlet weak var style: UITextField!
        @IBOutlet weak var ibu: UITextField!
        var textFieldHeightSize = 0.0 as CGFloat
        
        @IBOutlet weak var abvLabel: UILabel!
        @IBOutlet weak var IBULabel: UILabel!
        @IBOutlet weak var styleLabel: UILabel!
        @IBOutlet weak var nameLabel: UILabel!
        @IBOutlet weak var introText: UILabel!
       // var objectID:String!
        var brewery:Brewery?
        var pickOptionParse:[PFObject]? = [PFObject]()
        var i:Int = 0
        var breweryDict = [String:String?]()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.navigationController?.navigationBar.hidden = true

            self.nameBeer.delegate = self
            self.abv.delegate = self
            self.style.delegate = self
            self.ibu.delegate = self
            
            let pickerView = UIPickerView()
            self.queryParse()
            pickerView.delegate = self
            
            style.inputView = pickerView
            //se travar apagar
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: self.view.window)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: self.view.window)
            let bounds = UIScreen.mainScreen().bounds
            let width = bounds.size.width
            let height = bounds.size.height
           
            print(width)
            print(height)
            
            let screenHeight = UIScreen.mainScreen().bounds.height
            print(screenHeight)
            
            switch screenHeight {
            case 480:
                
                self.introText.font = UIFont(name: "Lato", size: 0)
                self.nameLabel.font = UIFont(name: "Lato", size: 13)
                self.IBULabel.font = UIFont(name: "Lato", size: 13)
                self.abvLabel.font = UIFont(name: "Lato", size: 13)
                self.styleLabel.font = UIFont(name: "Lato", size: 14)

                
            default: // rest of screen sizes
                break
            }
        
        }
        
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if segue.identifier == "successCreate"{
                if let destination = segue.destinationViewController as? BeerProfileVC {
                    destination.currentObject = sender as? PFObject
                }
            }
        }
        
        override func viewWillDisappear(animated: Bool) {
            NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: self.view.window)
            NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: self.view.window)
        }
        
        @IBAction func cancelButton(sender: AnyObject) {
            self.navigationController?.popToRootViewControllerAnimated(true)
        }

        @IBAction func saveObject(sender: AnyObject) {
            
            if self.nameBeer.text != ""{
                    if self.abv.text != ""{
                        if self.style.text != ""{
                            
                            if self.brewery == nil{
                                saveBrew()  
                            }else{
                                self.saveBeer(self.brewery)
                            }
                            
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
        
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    }
    
    //MARK: - PICKER METHODS
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
        print(self.pickOptionParse![row].objectForKey("name"))
        self.i = row
        return self.pickOptionParse![row].objectForKey("name") as? String

    }
    
    //Update textfield text when row is selected
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        style.text = self.pickOptionParse![row].objectForKey("name") as? String
        style.resignFirstResponder()

    }
    
    
    
    }
    
    //MARK: - KEYBOARDS METHODS
    extension AddBeer{
        override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            self.view.endEditing(true)
        }

        
        func textFieldShouldReturn(textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return false
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
//
    //MARK: - PARSE Methods
    
    extension AddBeer {
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

        
        
    }
    
    
  //MARK: - ALERT
    
    extension AddBeer{
       
        func saveBrew(){
            let name = self.breweryDict["name"]! as String!
            let country = self.breweryDict["country"]! as String!
            let contact = self.breweryDict["contact"]
            let address = self.breweryDict["address"]
            BreweryServices.saveNewBrewery(name, local: country, contact: contact!, address: address!) { (mensage, success) -> Void in
        
                if success{
                    let query = PFQuery(className:"Brewery")
                    query.whereKey("name", equalTo:name)
                    query.getFirstObjectInBackgroundWithBlock({ (object, error) -> Void in
                            if error == nil {
                                print(object)
                                self.saveBeer(object as? Brewery)
        
                            }else{
                                print(error)
                        }
                    })
                }
            }
        }
        
        
        
        
        
        
        func saveBeer(brewery:Brewery!){
            print("chamou")
            BeerServices.saveNewBeer(self.nameBeer.text, abv: self.abv.text, brewery: brewery, style: self.style.text, ibu: self.ibu.text, completionHandler: {  (success) -> Void in
        
        
                    if success{
                    print("Salvo")
                    let query = PFQuery(className:"Beer")
                    query.whereKey("name", equalTo:self.nameBeer.text!)
                    query.getFirstObjectInBackgroundWithBlock({ (object, erro) -> Void in
                        if object != nil {
                            self.performSegueWithIdentifier("successCreate", sender:object)
                        }else{
                            //erro ao salvar
                        }
                    })
                }
            })

            }
    
            
        func alertForUser(message:String){
            let alert = UIAlertController(title: "Atenção", message:message, preferredStyle:UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
        
    }
