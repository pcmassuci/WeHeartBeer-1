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
    
    let imagePaths = [ "beer1", "beer2", "beer3" ]
    var imageArray:[UIImage] = [UIImage]()
    
    
    // Closure to load local images with UIImage.named
    let imageLoader: ((imageView: UIImageView, imagePath : String, completion: (newImage: Bool) -> ()) -> ()) = {
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
        
        configureCollectionView(false)
        
    }
    
    // Function CollectionView
    func configureCollectionView(parseLoad:Bool) {
        
        // NOTE: the collectionView IBOutlet class must be declared as MVCarouselCollectionView in Interface Builder, otherwise this will crash.
        collectionView.selectDelegate = self
        if parseLoad {
        //   collectionView.imagePaths = self.imageArray
        }else{
        collectionView.imagePaths = imagePaths
        }
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
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.queryCarousel()
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

extension CarouselVC {
    
    // Query return if Featured Beer.
    func queryCarousel () {
        
        let query = PFQuery(className:"Featured")
        query.whereKey("active", equalTo: true)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        print(object.objectId)
                        
                        print(object.valueForKey("beer")?.objectId)
                        
                      self.queryBeer((object.valueForKey("beer")?.objectId)!)
                        
                    }
                    //self.configureCollectionView(true)
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }

    }
    
    
    func queryBeer (featuredId: String) {
        
        let query = PFQuery(className:"Beer")
        query.whereKey("objectId", equalTo: featuredId  )
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        print(object)
                        
                        //print(object.valueForKey("Photo"))
                        self.updateData(object)
                    }
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
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
                        
                        print("Pc que fez!!!!!")
                        
                        let image = UIImage(data:imageData)
                        self.imageArray.append(image!)
                        
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
