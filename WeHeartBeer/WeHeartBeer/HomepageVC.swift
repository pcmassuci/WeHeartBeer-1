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



class HomepageVC: UIViewController {
    
    
    // MARK: - IBOutlets
    
    @IBOutlet var challengeLink: UIImageView!
    //@IBOutlet weak var backgroundImageview: UIImageView!
    @IBOutlet var collectionView : MVCarouselCollectionView!
    @IBOutlet var pageControl : MVCarouselPageControl!
    var dict = [String:UIImage]()
    var images : [UIImage] = []
    var features:[PFObject?] = [PFObject?]()
    //var string = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("to aqui")
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 250.0/255.0, green: 170.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()

        //view.translatesAutoresizingMaskIntoConstraints = true
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        
        //Remove all images after change view
        self.dict.removeAll()
        self.queryCarousel()

    }
    
        
    
    // MARK: - ChallengeLink
    func challengeLinkClicked(){
        performSegueWithIdentifier("challengeSegue", sender: nil)
    }
    
    // Closure to load local images with UIImage.named
    let imageLoader: ((imageView: UIImageView, image : UIImage, completion: (newImage: Bool) -> ()) -> ()) = {
        (imageView: UIImageView, image : UIImage, completion: (newImage: Bool) -> ()) in
        
        imageView.image = image
        completion(newImage: imageView.image != nil)
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

extension HomepageVC: MVCarouselCollectionViewDelegate {
    
    
    // Function CollectionView
    func configureCollectionView(parseLoad:Bool) {
        
        // NOTE: the collectionView IBOutlet class must be declared as MVCarouselCollectionView in Interface Builder, otherwise this will crash.
        print(self.dict.count)
        
        
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
    
}


//Query Carousel
extension HomepageVC {
    
    // Query return if Featured Beer.
    func queryCarousel () {
        FeaturedDAO.getDictBeerAndImage { (dict, array, success) -> Void in
            if success{
            
                for (key, value) in dict{
                    self.images.append(value)
                    self.features.append(key)
                    //print("\(key) -> \(value)")
                    self.configureCollectionView(true)
                }
            }else{
                //imagem generica
            }
        }
    }



}