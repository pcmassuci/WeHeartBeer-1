//
//  Homepage.swift
//  WeHeartBeer
//
//  Created by Júlio César Garavelli on 23/10/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import UIKit
import Foundation



class HomepageVC: UIViewController {
    
    
    // MARK: - IBOutlets
    
  
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var challengeLink: UIImageView!
    var images : [UIImage] = []
    var features:[PFObject?] = [PFObject?]()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
        self.challengeLink.userInteractionEnabled = true
        self.challengeLink.addGestureRecognizer(tapGestureRecognizer)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 250.0/255.0, green: 170.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
           self.queryImages()
    }

    // MARK: - ChallengeLink
    func imageTapped(img: AnyObject){
        performSegueWithIdentifier("challengeSegue", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "segueDestaqueBeer") {
            if let destination = segue.destinationViewController  as? BeerProfileVC{
                let row = sender as! Int 
                print(self.features[row])
                destination.currentObject = self.features[row]
            }
        }
    }
    
}

extension HomepageVC: UICollectionViewDataSource{
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let itens = self.images.count
        
        if itens == 0 {
            return 1
        } else {
        return itens
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("colCell", forIndexPath: indexPath) as! HomeCollectionViewCell
        let control = self.images.count
        if control != 0 {
        cell.featureImage.image = self.images[indexPath.row]
        }
        return cell
    }
    
}
extension HomepageVC:UICollectionViewDelegate{
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("segueDestaqueBeer", sender: indexPath.row)
        
    }
    
    
}

//Query Carousel
extension HomepageVC {
    
    // Query return if Featured Beer.
    func queryImages () {
        FeaturedDAO.getDictBeerAndImage { (dict, array, success) -> Void in
            if success{
            
                for (key, value) in dict{
                    self.images.append(value)
                    self.features.append(key)
                    //print("\(key) -> \(value)")
                    //self.configureCollectionView(true)
                }
                self.collectionView.reloadData()
            }else{
                //imagem generica
            }
        }
    }



}