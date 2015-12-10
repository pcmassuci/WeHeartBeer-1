//
//  ChallengeVC.swift
//  WeHeartBeer
//
//  Created by Matheus Santos Lopes on 22/10/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import UIKit

class ChallengeVC: UIViewController {
    
    @IBOutlet weak var challengeImage: UIImageView!
    @IBOutlet weak var challengeTitle: UILabel!
    @IBOutlet weak var challengeDescription: UILabel!
    @IBOutlet weak var challengeFb: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.challengeImage.image = UIImage(named:"now-pouring")
        self.view.addSubview(challengeImage)
        
        challengeTitle.text = "Challenge 1"
        challengeDescription.text = "Para participar desse challenge você deve experimentar e compartilhar na nossa página 10 estilos diferentes de cerveja. O ganhador irá ganhar uma camiseta exlusiva do BeerLove"
        //challengeDescription.adjustsFontSizeToFitWidth = true
        challengeDescription.sizeToFit()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255.0/255.0, green: 192.0/255.0, blue: 3.0/255.0, alpha: 1.0)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func challengeFb(sender: UIButton){
        
        let fbURLWeb: NSURL = NSURL(string: "https://www.facebook.com/Matheusfccfaj")!
        //let fbURLID: NSURL = NSURL(string: "fb://profile/719245588122387")!
        
        UIApplication.sharedApplication().openURL(fbURLWeb)
        //
        //        if(UIApplication.sharedApplication().canOpenURL(fbURLID)){
        //            // FB installed
        //            UIApplication.sharedApplication().openURL(fbURLID)
        //        } else {
        //            // FB is not installed, open in safari
        //            UIApplication.sharedApplication().openURL(fbURLWeb)
        //        }
        
    }
    
}

// MARK: Fragão

// frangao se der merda da uma olhada nesse link http://stackoverflow.com/questions/29504146/parsefacebook-sdk-issues-use-of-unresolved-identifier-pffacebookutils
//
//override func viewDidLoad() {
//    super.viewDidLoad()
//    view.backgroundColor = UIColor(red:0.07, green:0.07, blue:0.07, alpha:1.0)
//
//
//    //        let query = User.query()
//    ////        query.whereKey("objectId", equalTo: "3eWigsY0bZ")
//    //        query?.whereKey("objectId", equalTo: "3eWigsY0bZ")
//    //        let user = query?.getFirstObject() as! User
//    //        println(user)
//    //        UserServices.findBandsFromUser(user, completionHandler: { (bands, success) -> Void in
//    //            if success{
//    //                println(bands)
//    //            }
//    //        })
//
//
//    if UserServices.loggedUser(){
//        self.performSegueWithIdentifier("loginSegue", sender: self)
//    }
//
//    // Do any additional setup after loading the view.
//}
//override func viewDidAppear(animated: Bool) {
//    super.viewDidAppear(animated)
//    //navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: true) //or animated: false
//    self.navigationController?.navigationBar.hidden = true
//}
//override func didReceiveMemoryWarning() {
//    super.didReceiveMemoryWarning()
//
//    // Dispose of any resources that can be recreated.
//}
//
//
//
//@IBAction func loginNormalClicked(sender: AnyObject) {
//    UserServices.loginNormalUser(self.emailField.text, password: self.passwordField.text) { (success) -> Void in
//        if success{
//            self.performSegueWithIdentifier("loginSegue", sender: self)
//        }else{
//            //TODO
//        }
//    }
//}
//
//
//@IBAction func loginFacebookClicked(sender: AnyObject) {
//
//    UserServices.loginFaceUser { (success) -> Void in
//        if success{
//            self.performSegueWithIdentifier("loginSegue", sender: self)
//        }else{
//            //TODO
//        }
//    }
//}
//
//
///*
//// MARK: - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//// Get the new view controller using segue.destinationViewController.
//// Pass the selected object to the new view controller.
//}
//*/
//
//}
