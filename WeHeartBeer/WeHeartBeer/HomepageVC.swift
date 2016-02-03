//
//  Homepage.swift
//  WeHeartBeer
//
//  Created by Júlio César Garavelli on 23/10/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import UIKit
import MVCarouselCollectionView
import Foundation

typealias FindObjectsCompletionHandler = (beer:[PFObject]?,success:Bool) -> Void
typealias FindObjectCompletionHandler = (obj:PFObject?,success:Bool) -> Void

class HomepageVC: UIViewController, MVCarouselCollectionViewDelegate {
    
    
    // MARK: - IBOutlets
    
    @IBOutlet var challengeLink: UIImageView!
    //@IBOutlet weak var backgroundImageview: UIImageView!
    @IBOutlet var collectionView : MVCarouselCollectionView!
    @IBOutlet var pageControl : MVCarouselPageControl!
    var dict = [Beer:UIImage]()
    // MARK: - UICollectionViewDataSource
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.navigationController?.navigationBar.barTintColor = UIColor(red: 250.0/255.0, green: 170.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        
        //let gesture = UITapGestureRecognizer(target: self, action: "challengeLinkClicked")
        
        //self.challengeLink.addGestureRecognizer(gesture)
        
        // Do any additional setup after loading the view.
        
        // let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
        // self.image.userInteractionEnabled = true
        // self.image.addGestureRecognizer(tapGestureRecognizer)
        
        // Do any additional setup after loading the view.
        view.translatesAutoresizingMaskIntoConstraints = false
        
        //self.pageControl.numberOfPages = images.count
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        
        //Remove all images after change view
        self.dict.removeAll()
       // self.images.removeAll()
        self.queryCarousel()

    }
    
        
    
    // MARK: - ChallengeLink
    func challengeLinkClicked(){
        performSegueWithIdentifier("challengeSegue", sender: nil)
    }
    
    var images : [UIImage] = []
    var features:[PFObject?] = [PFObject?]()
//
    
    // Closure to load local images with UIImage.named
    let imageLoader: ((imageView: UIImageView, image : UIImage, completion: (newImage: Bool) -> ()) -> ()) = {
        (imageView: UIImageView, image : UIImage, completion: (newImage: Bool) -> ()) in
        
        imageView.image = image
        completion(newImage: imageView.image != nil)
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
        print("index: \(indexPath.row)")
        
        // Do something with cell selection
        // Send indexPath.row as index to use
        //
        self.performSegueWithIdentifier("segueDestaqueBeer", sender:indexPath);
    }
    
    func carousel(carousel: MVCarouselCollectionView, didScrollToCellAtIndex cellIndex : NSInteger) {
        
        // Page changed, can use this to update page control
     //   self.pageControl.currentPage = cellIndex
    }
    
    // MARK: IBActions
    @IBAction func pageControlEventChanged(sender: UIPageControl) {
        
        self.collectionView.setCurrentPageIndex(sender.currentPage, animated: true)
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "segueDestaqueBeer") {
            if let destination = segue.destinationViewController  as? BeerProfileVC{
                print(self.features[(sender?.row)!])
                destination.currentObject = self.features[(sender?.row)!]
            }
        }
    }
    
}




//Query Carousel
extension HomepageVC {
    
    // Query return if Featured Beer.
    func queryCarousel () {
        FeaturedDAO.getDictBeerAndImage { (dict, success) -> Void in
            if success{
          //  self.dict = dict
        }
            }

}

}