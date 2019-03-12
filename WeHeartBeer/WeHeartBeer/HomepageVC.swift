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
    @IBOutlet weak var activeIndicator: UIActivityIndicatorView?
    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet var challengeLink: UIImageView?
    @IBOutlet weak var pageControl: UIPageControl?
    @IBOutlet weak var challengeName: UILabel!
    
    var images : [UIImage] = []
    var features:[Any?] = [Any?]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewDidLoad()
    }
    
    func setupColors() {
        self.navigationController?.navigationBar.barTintColor = .yellowBeer
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    func setupViewDidLoad() {
        self.challengeImage()
        self.configurePageControl()
    
        self.tintBarUp(view: self.view)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector(("imageTapped:")))
        
        self.challengeLink?.isUserInteractionEnabled = true
        self.challengeLink?.addGestureRecognizer(tapGestureRecognizer)
        
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        
        view.translatesAutoresizingMaskIntoConstraints = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.internetCheck(){
        }else{
            self.alert(title: "Atenção!", message: "Verifique sua conexão com a Internet", option: false, action: nil)
        }
        self.navigationController?.isNavigationBarHidden = true
        self.images.removeAll()
                self.features.removeAll()
        self.queryImages()
    }
    
    // MARK: - ChallengeLink
    func imageTapped(img: AnyObject){
        performSegue(withIdentifier: "challengeSegue", sender: nil)
    }
    
    
    
    // MARK: IBActions
    @IBAction func pageControlEventChanged(sender: UIPageControl) {
//    self.collectionView.setCurrentPageIndex(sender.currentPage, animated: true)

    }
    
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //        if (segue.identifier == "segueDestaqueBeer") {
        //            if let destination = segue.destination  as? BeerProfileVC{
        //                let row = sender as! Int
        //                                destination.currentObject = self.features[row]
        //            }
        //        }
    }
    
}

extension HomepageVC: UICollectionViewDataSource{
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let itens = self.images.count
        
        if itens == 0 {
            
            return 1
        } else {
            return itens
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colCell", for: indexPath) as! HomeCollectionViewCell
        let control = self.images.count
        if control != 0 {
            
            cell.featureImage.image = self.images[indexPath.row]
//            cell.featuredName.text = ((self.features[indexPath.row]? as AnyObject).object(forKey: "name") as! String)
            cell.layoutIfNeeded()
        }
        return cell
    }
}

extension HomepageVC: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if self.features.count != 0 {
            performSegue(withIdentifier: "segueDestaqueBeer", sender: indexPath.row)
        }else{
            self.alert(title: "Por Favor Aguarde!", message: "Estamos carregando dos nossos servidores nossos destaques", option:false, action: nil)
        }
        
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return collectionView.frame.size
    }
}

extension HomepageVC {
    
    // Query return if Featured Beer.
    func queryImages () {
        self.activeIndicator?.isHidden = false
        self.activeIndicator?.startAnimating()
        
        //chama imagem
        
        }
    }



extension HomepageVC {
    private func configurePageControl() {
        self.pageControl?.numberOfPages = self.features.count
    }
    
    func challengeImage(){
//        ChallengeVC.getChallengeforParse { (challenge, success) -> Void in
//            if success{
//
//
//                if challenge?.objectForKey("name") != nil{
//                    self.challengeName.text = (challenge?.objectForKey("name") as! String)
//                    print(challenge?.objectForKey("name"))
//                }
//                let getImage = challenge?.objectForKey("image") as? PFFile
//                if getImage != nil{
//                    ImageDAO.getImageFromParse(getImage, ch: { (image, success) -> Void in
//                        if success{
//                            if image != nil {
//                                self.challengeLink.image = image
//                            }else{
//
//                                self.challengeLink.image = UIImage(named:"now-pouring")
//                                // não tem imagem
//                            }
//
//                        }else{
//                            //erro ao obter imagem
//                            self.challengeLink.image = UIImage(named:"now-pouring")
//                        }
//                    })
//                }else{
//
//                    self.challengeLink.image = UIImage(named:"now-pouring")
//                }
//
//
//
//
//
//            }
//
//        }
    }
}

