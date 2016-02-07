//
//  Homepage.swift
//  WeHeartBeer
//
//  Created by Júlio César Garavelli on 23/10/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import UIKit
import Foundation




class HomepageVC: UIViewController, UIPageViewControllerDelegate {
    
    
    // MARK: - IBOutlets
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var challengeLink: UIImageView!
    var images : [UIImage] = []
    var features:[PFObject?] = [PFObject?]()
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var challengeName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tintBarUp(self.view)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
        self.challengeLink.userInteractionEnabled = true
        self.challengeLink.addGestureRecognizer(tapGestureRecognizer)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 250.0/255.0, green: 170.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        //view.translatesAutoresizingMaskIntoConstraints = true
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        self.images.removeAll()
        self.features.removeAll()
        self.queryImages()
        self.challengeImage()
    }
    
    // MARK: - ChallengeLink
    func imageTapped(img: AnyObject){
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
        
         ///self.collectionView.setCurrentPageIndex(sender.currentPage, animated: true)
        
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
            cell.layoutIfNeeded()
        }
        return cell
    }
}

extension HomepageVC: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("segueDestaqueBeer", sender: indexPath.row)
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            return collectionView.frame.size
    }
}

//Query Carousel
extension HomepageVC {
    
    // Query return if Featured Beer.
    func queryImages () {
        

        FeaturedDAO.getDictBeerAndImage { (dict, array, success) -> Void in
            if success{
               // var dictA = [PFObject:UIImage]()
               let values = dict.count
                for var i = 1 ; i <= values; i++ {
                   let dictA = dict[i]!
                    for (key, value) in dictA{
                                            self.images.append(value)
                                            self.features.append(key)
           
                    }
                    
                }
            
                self.collectionView.reloadData()
                
            }else{
                //imagem generica
            }
        }
    }
    
}


extension HomepageVC {
    
    func challengeImage(){
        ChallengeDAO.getChallengeforParse { (challenge, success) -> Void in
            if success{
                
                let chDescrition = challenge?.objectForKey("description") as! String
                let chTitle = challenge?.objectForKey("name") as! String
                
                let getImage = challenge?.objectForKey("image") as? PFFile
                if getImage != nil{
                    ImageDAO.getImageFromParse(getImage, ch: { (image, success) -> Void in
                        if success{
                            if image != nil {
                                self.challengeLink.image = image
                                
                            }else{
                                print("Nao tem imagem")
                                self.challengeLink.image = UIImage(named:"now-pouring")
                                // não tem imagem
                            }
                            
                        }else{
                            //erro ao obter imagem
                            self.challengeLink.image = UIImage(named:"now-pouring")
                        }
                    })
                }else{
                    print("imagem generica")
                    self.challengeLink.image = UIImage(named:"now-pouring")
                }
                
                
//                
//                
                self.challengeName.text = chTitle

//
    }
    
        }
    }
}

