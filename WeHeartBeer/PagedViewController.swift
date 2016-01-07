////
////  PagedViewController.swift
////  BeerLove
////
////  Created by Paulo César Morandi Massuci on 08/12/15.
////  Copyright © 2015 Fernando H M Bastos. All rights reserved.
////
//

import UIKit

typealias FindObjectsCompletionHandler = (beer:[PFObject]?,success:Bool) -> Void
typealias FindObjectCompletionHandler = (obj:PFObject?,success:Bool) -> Void

class PagedViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var image: UIImageView!
    var feat:PFObject!
    var object:PFObject!
    override func viewDidLoad() {
            super.viewDidLoad()
//            let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
//            self.image.userInteractionEnabled = true
//            self.image.addGestureRecognizer(tapGestureRecognizer)
        }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.findFeat { (beer, success) -> Void in
            if success {
                self.feat = beer![0]
                let objectID = self.feat["beer"].objectId
                self.findBeer(objectID, completionHandler: { (obj, success) -> Void in
                    if success{
                        self.object = obj
                        self.updateData(self.object)
                        
                    }
                })

            }
        }
      
    }
    
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }

    func imageTapped(img: AnyObject)
    {
      //  print(self.beer)
    self.performSegueWithIdentifier("challengeToBeer", sender: nil)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "challengeToBeer"{
            if let destination = segue.destinationViewController  as? BeerProfileVC{
                destination.currentObject = self.object
            }
        }
    }
    
    func findFeat(completionHandler:FindObjectsCompletionHandler){
        var query = PFQuery(className:"Featured")
        query.findObjectsInBackgroundWithBlock { (result:[PFObject]?, error:NSError?) -> Void in
            if error == nil {
                if let result = result as? [PFObject]? {
                    completionHandler(beer: result, success: true)
                }else{
                    print("erro dao")
                    completionHandler(beer:nil,success: false)
                }
            }else{
                print("erro dao 2")
                completionHandler(beer:nil,success: false)
            }
            
            
        }
        
    }
    
    func findBeer(objID: String!, completionHandler:FindObjectCompletionHandler){
        var query = PFQuery(className:"Beer")
        query.getObjectInBackgroundWithId(objID) { (result:PFObject?, error:NSError?) -> Void in
            if error == nil {
                if let result = result as? PFObject? {
                    completionHandler(obj: result, success: true)
                }else{
                    print("erro dao")
                    completionHandler(obj:nil,success: false)
                }
            }else{
                print("erro dao 2")
                completionHandler(obj:nil,success: false)
            }
        
        }
    }
    func updateData(beer: PFObject?){
        
        // pegando a foto do parse
        
        if beer!.objectForKey("Photo") != nil{
            let userImageFile = beer!.objectForKey("Photo") as! PFFile
            
            userImageFile.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        let image = UIImage(data:imageData)
                        self.image.image = image
                        self.image.contentMode = UIViewContentMode.ScaleAspectFit
                        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
                        self.image.userInteractionEnabled = true
                        self.image.addGestureRecognizer(tapGestureRecognizer)
                        
                    }else{
                        print("sem imagem")
                    }
                }
                
            }
        }else{
            print("erro na imagem")
        }
        
        
    }




}



//Gambiarra do Fernando/Julio
//import UIKit
//
//class PagedViewController: UIViewController, UIScrollViewDelegate {
//    
//    @IBOutlet weak var pageControl: UIPageControl!
//
//    @IBOutlet weak var scrollView: UIScrollView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        //1
//        //self.scrollView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
//        self.scrollView.frame = CGRectOffset(scrollView.frame, scrollView.contentSize.width, 0)
//        let scrollViewWidth:CGFloat = self.scrollView.frame.width
//        let scrollViewHeight:CGFloat = self.scrollView.frame.height
//       
//        //3
//        let imgOne = UIImageView(frame: CGRectMake(0, 0,scrollViewWidth, scrollViewHeight))
//        imgOne.image = UIImage(named: "beer1")
//        let imgTwo = UIImageView(frame: CGRectMake(scrollViewWidth, 0,scrollViewWidth, scrollViewHeight))
//        imgTwo.image = UIImage(named: "beer2")
//        let imgThree = UIImageView(frame: CGRectMake(scrollViewWidth*2, 0,scrollViewWidth, scrollViewHeight))
//        imgThree.image = UIImage(named: "beer3")
//        let imgFour = UIImageView(frame: CGRectMake(scrollViewWidth*3, 0,scrollViewWidth, scrollViewHeight))
//        imgFour.image = UIImage(named: "beer4")
//        
//        self.scrollView.addSubview(imgOne)
//        self.scrollView.addSubview(imgTwo)
//        self.scrollView.addSubview(imgThree)
//        self.scrollView.addSubview(imgFour)
//        
//        //4
//        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width * 4,self.scrollView.frame.height)
//        self.scrollView.delegate = self
//        self.pageControl.currentPage = 0
//        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "moveToNextPage", userInfo: nil, repeats: true)
//
//
//        // Do any additional setup after loading the view.
//    }
//    func scrollViewDidEndDecelerating(scrollView: UIScrollView){
//        
//        // Test the offset and calculate the current page after scrolling ends
//        let pageWidth:CGFloat = CGRectGetWidth(scrollView.frame)
//        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
//        
//        // Change the indicator
//        self.pageControl.currentPage = Int(currentPage);
//        
//        // Change the text accordingly
//  
//            UIView.animateWithDuration(1.0, animations: {() -> Void in })
//        
//    }
//

//    
//    func moveToNextPage (){
//        
//        let pageWidth:CGFloat = CGRectGetWidth(self.scrollView.frame)
//        let maxWidth:CGFloat = pageWidth * 4
//        let contentOffset:CGFloat = self.scrollView.contentOffset.x
//        
//        var slideToX = contentOffset + pageWidth
//        
//        if  contentOffset + pageWidth == maxWidth{
//            slideToX = 0
//        }
//        self.scrollView.scrollRectToVisible(CGRectMake(slideToX, 0, pageWidth, CGRectGetHeight(self.scrollView.frame)), animated: true)
//    }
//
//
//}
