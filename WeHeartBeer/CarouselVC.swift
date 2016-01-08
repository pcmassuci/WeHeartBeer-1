//
//  CarouselVC.swift
//  BeerLove
//
//  Created by Júlio César Garavelli on 05/01/16.
//  Copyright © 2016 Fernando H M Bastos. All rights reserved.
//

import UIKit
import MVCarouselCollectionView

class CarouselVC: UIViewController, MVCarouselCollectionViewDelegate {
    
    // Local images
    let imagePaths = [ "beer1", "beer2", "beer3" ]
    //Or
    //var imagePaths : [String] = []
    
    // Closure to load local images with UIImage.named
    let imageLoader: ((imageView: UIImageView, imagePath : String, completion: (newImage: Bool) -> ()) -> ()) = {
        (imageView: UIImageView, imagePath : String, completion: (newImage: Bool) -> ()) in
        
        imageView.image = UIImage(named:imagePath)
        completion(newImage: imageView.image != nil)
    }
    
    
    @IBOutlet var collectionView : MVCarouselCollectionView!
    @IBOutlet var pageControl : MVCarouselPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        // Do any additional setup after loading the view.
        self.pageControl.numberOfPages = imagePaths.count
        
        //configureCollectionView
        self.collectionView.selectDelegate = self
        self.collectionView.imagePaths = imagePaths
        self.collectionView.commonImageLoader = self.imageLoader
        //collectionView.maximumZoom = 2.0
        self.collectionView.reloadData()
    }
    
//    func configureCollectionView() {
//        
//        // NOTE: the collectionView IBOutlet class must be declared as MVCarouselCollectionView in Interface Builder, otherwise this will crash.
//        self.collectionView.selectDelegate = self
//        self.collectionView.imagePaths = imagePaths
//        self.collectionView.commonImageLoader = self.imageLoader
//        //collectionView.maximumZoom = 2.0
//        self.collectionView.reloadData()
//    }
    
//    func addAsChildViewController(parentViewController : UIViewController, attachToView parentView: UIView) {
//        
//        parentViewController.addChildViewController(self)
//        self.didMoveToParentViewController(parentViewController)
//        parentView.addSubview(self.view)
//        self.autoLayout(parentView)
//    }
//    
//    func autoLayout(parentView: UIView) {
//        
//        self.matchLayoutAttribute(.Left, parentView:parentView)
//        self.matchLayoutAttribute(.Right, parentView:parentView)
//        self.matchLayoutAttribute(.Bottom, parentView:parentView)
//        self.matchLayoutAttribute(.Top, parentView:parentView)
//    }
//    
//    func matchLayoutAttribute(attribute : NSLayoutAttribute, parentView: UIView) {
//        
//        parentView.addConstraint(
//            NSLayoutConstraint(item:self.view, attribute:attribute, relatedBy:NSLayoutRelation.Equal, toItem:parentView, attribute:attribute, multiplier:1.0, constant:0))
//    }
    
    
    // MARK:  MVCarouselCollectionViewDelegate
    func carousel(carousel: MVCarouselCollectionView, didSelectCellAtIndexPath indexPath: NSIndexPath) {
        
        // Do something with cell selection
        // Send indexPath.row as index to use
        self.performSegueWithIdentifier("FullScreenSegue", sender:indexPath);
    }
    
    func carousel(carousel: MVCarouselCollectionView, didScrollToCellAtIndex cellIndex : NSInteger) {
        
        // Page changed, can use this to update page control
        
        self.pageControl.currentPage = cellIndex
    }
    
    // MARK: IBActions
    @IBAction func pageControlEventChanged(sender: UIPageControl) {
        
        self.collectionView.setCurrentPageIndex(sender.currentPage, animated: true)
        
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
//    
//    // MARK: FullScreenViewControllerDelegate
//    func willCloseWithSelectedIndexPath(indexPath: NSIndexPath) {
//        
//        self.collectionView.resetZoom()
//        self.collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition:UICollectionViewScrollPosition.CenteredHorizontally, animated:false)
//    }
    

}
