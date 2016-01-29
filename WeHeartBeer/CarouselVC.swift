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


typealias FindObjectsCompletionHandler = (beer:[PFObject]?,success:Bool) -> Void
typealias FindObjectCompletionHandler = (obj:PFObject?,success:Bool) -> Void


class CarouselVC: UIViewController, MVCarouselCollectionViewDelegate {
    
    // Local images
    //let imagePaths = [ "beer1", "beer2", "beer3" ]
    
    var images : [UIImage] = []
    var features:[PFObject?] = [PFObject?]()
    
    
    // Closure to load local images with UIImage.named
    let imageLoader: ((imageView: UIImageView, image : UIImage, completion: (newImage: Bool) -> ()) -> ()) = {
        (imageView: UIImageView, image : UIImage, completion: (newImage: Bool) -> ()) in
        
        imageView.image = image
        completion(newImage: imageView.image != nil)
    }
    
    
    //IBOutlets
    @IBOutlet var collectionView : MVCarouselCollectionView!
    @IBOutlet var pageControl : MVCarouselPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
        // self.image.userInteractionEnabled = true
        // self.image.addGestureRecognizer(tapGestureRecognizer)
        
        // Do any additional setup after loading the view.
        //view.translatesAutoresizingMaskIntoConstraints = false
        
        self.pageControl.numberOfPages = images.count
        self.images.removeAll()
    }
    
    // Function CollectionView
    func configureCollectionView(parseLoad:Bool) {
        
        // NOTE: the collectionView IBOutlet class must be declared as MVCarouselCollectionView in Interface Builder, otherwise this will crash.
        collectionView.selectDelegate = self
        collectionView.images = self.images
        collectionView.commonImageLoader = self.imageLoader
        
        self.collectionView.reloadData()
        
        
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
        
        //Remove all images after change view
        self.images.removeAll()
        self.queryCarousel()
        
    }
}


//Query Carousel
extension CarouselVC {
    
    // Query return if Featured Beer.
    func queryCarousel () {
        
        FeaturedDAO.queryFeatured { (objs, success) -> Void in
            if success {
                for obj in objs!{
                    self.features.append(obj)
                    self.queryBeer((obj.valueForKey("beer")?.objectId)!)
                    self.configureCollectionView(false)
                }
                
            }else{
                //tratar error
            }
        }
        
    }
    
    //Query Beer
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
    
    //Query updateData
    func updateData(beer: PFObject?){
        
        // pegando a foto do parse
        if beer!.objectForKey("Photo") != nil{
            let imageFile = beer!.objectForKey("Photo") as! PFFile
            ImageDAO.getImageFromParse(imageFile, ch: { (image, success) -> Void in
                if success{
                    self.images.append(image!)
                    self.configureCollectionView(true)
                    print(self.images.count)
                    
                }else{
                    // carregar imagem away
                }
            })
            
        }else {
            // carrega image away
        }
    }
}
