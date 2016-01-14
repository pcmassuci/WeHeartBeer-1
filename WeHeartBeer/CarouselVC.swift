//
//  CarouselVC.swift
//  BeerLove
//
//  Created by Júlio César Garavelli on 05/01/16.
//  Copyright © 2016 Fernando H M Bastos. All rights reserved.
//

import UIKit
import MVCarouselCollectionView
import Foundation


class CarouselVC: UIViewController, MVCarouselCollectionViewDelegate{
    
    typealias FindObjectsCompletionHandler = (beer:[PFObject]?,success:Bool) -> Void
    typealias FindObjectCompletionHandler = (obj:PFObject?,success:Bool) -> Void
    
    // Local images
    
    @IBOutlet weak var image: UIImageView!
    let imagePaths = [ "beer1", "beer2", "beer3" ]
    var feat:[PFObject]!
    var object:PFObject!
    
    // Closure to load local images with UIImage.named
    let imageLoader: ((imageView: UIImageView, imagePath : String, completion: (newImage: Bool) -> ()) -> ()) = {
        (imageView: UIImageView, imagePath : String, completion: (newImage: Bool) -> ()) in
        
        imageView.image = UIImage(named:imagePath)
        completion(newImage: imageView.image != nil)
    }
    
    // Closure to load remote images with UIImage.named
    let imageLoader2: ((imageView: UIImageView, imagePath : String, completion: (newImage: Bool) -> ()) -> ()) = {
        (imageView: UIImageView, imagePath : String, completion: (newImage: Bool) -> ()) in
        
        imageView.image = UIImage(named:imagePath)
        completion(newImage: imageView.image != nil)
    }
    
    //IBOutlets
    @IBOutlet var collectionView : MVCarouselCollectionView!
    @IBOutlet var pageControl : MVCarouselPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.translatesAutoresizingMaskIntoConstraints = false
        
        self.pageControl.numberOfPages = imagePaths.count
        
        configureCollectionView()
        
    }
    
    // Function CollectionView
    func configureCollectionView() {
        
        // NOTE: the collectionView IBOutlet class must be declared as MVCarouselCollectionView in Interface Builder, otherwise this will crash.
        collectionView.selectDelegate = self
        collectionView.imagePaths = imagePaths
        collectionView.commonImageLoader = self.imageLoader
        //collectionView.maximumZoom = 0
        collectionView.reloadData()
    }
    
    
    // MARK:  MVCarouselCollectionViewDelegate
    func carousel(carousel: MVCarouselCollectionView, didSelectCellAtIndexPath indexPath: NSIndexPath) {
        
        // Do something with cell selection
        // Send indexPath.row as index to use
        //
        //self.performSegueWithIdentifier("FullScreenSegue", sender:indexPath);
    }
    
    func carousel(carousel: MVCarouselCollectionView, didScrollToCellAtIndex cellIndex : NSInteger) {
        
        // Page changed, can use this to update page control
        
        self.pageControl.currentPage = cellIndex
    }
    
    // MARK: IBActions
    @IBAction func pageControlEventChanged(sender: UIPageControl) {
        
        self.collectionView.setCurrentPageIndex(sender.currentPage, animated: true)
        
    }
    
    
    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        self.findFeat { (beer, success) -> Void in
//            if success {
//                self.feat = beer![0]
//                let objectID = self.feat["beer"].objectId
//                self.findBeer(objectID, completionHandler: { (obj, success) -> Void in
//                    if success{
//                        self.object = obj
//                        self.updateData(self.object)
//                        
//                    }
//                })
//                
//            }
//        }
//        
//    }
    
    // MARK: Query take table Featured from Parse.
    func findFeat(completionHandler:FindObjectsCompletionHandler){
        
        let query = PFQuery(className:"Featured")
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
    
    // MARK: Query take table Beer from Parse.
    func findBeer(objID: String!, completionHandler:FindObjectCompletionHandler){
        let query = PFQuery(className:"Beer")
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
                        self.image.contentMode = UIViewContentMode.ScaleAspectFill
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
    
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //
    //        if segue.identifier == "FullScreenSegue" {
    //
    //            let nc = segue.destinationViewController as? UINavigationController
    //            let vc = nc?.viewControllers[0] as? MVFullScreenCarouselViewController
    //
    //            if let vc = vc {
    //                vc.imageLoader = self.imageLoader
    //                vc.imagePaths = self.imagePaths
    //                vc.delegate = self
    //                vc.title = self.parentViewController?.navigationItem.title
    //                if let indexPath = sender as? NSIndexPath {
    //                    vc.initialViewIndex = indexPath.row
    //                }
    //            }
    //        }
    //    }
    
}
