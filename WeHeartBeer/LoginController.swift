//
//  LoginController.swift
//  BeerLove
//
//  Created by Paulo César Morandi Massuci on 17/02/16.
//  Copyright © 2016 Fernando H M Bastos. All rights reserved.
//

import UIKit

class LoginController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if UserServices.loggedUser(){
            print("foi")
            performSegueWithIdentifier("loggedSegue", sender: nil)
        }else{
            print("nao foi")
            performSegueWithIdentifier("noLoggedSegue", sender: nil)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
