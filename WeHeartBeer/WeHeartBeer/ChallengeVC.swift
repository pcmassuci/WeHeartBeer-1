//
//  ChallengeVC.swift
//  WeHeartBeer
//
//  Created by Matheus Santos Lopes on 22/10/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import UIKit

class ChallengeVC: UIViewController {
    
    @IBOutlet weak var challengeImage: UIImageView!
    @IBOutlet weak var challengeTitle: UILabel!
    @IBOutlet weak var challengeDescription: UILabel!
    @IBOutlet weak var challengeFb: UIButton!
    
    @IBOutlet weak var challengePrize: UILabel!
    
    @IBOutlet weak var separatorA: UIImageView!
    
    @IBOutlet weak var separatorB: UIImageView!
    
    @IBOutlet weak var prizeIcon: UIImageView!
    @IBOutlet weak var fbImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.challengeImage.image = UIImage(named:"now-pouring")
        //self.view.addSubview(challengeImage)
        
        challengeTitle.text = "Challenge"
        challengeDescription.text = "Carregando"
        challengeTitle.text = "1º Desafio Beer Love!"
        challengeDescription.text = "Para participar desse challenge você deve experimentar e compartilhar na nossa página 10 estilos diferentes de cerveja."
        //challengeDescription.adjustsFontSizeToFitWidth = true
        challengeDescription.sizeToFit()
        
        self.navigationController?.navigationBarHidden = false

        self.navigationController?.navigationBar.barTintColor = UIColor(red: 250.0/255.0, green: 170.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        
        let screenHeight = UIScreen.mainScreen().bounds.height
        print(screenHeight)
        
        switch screenHeight {
        case 480:
            
            self.challengeTitle.font = UIFont(name: "Lato", size: 20)
            self.challengeDescription.font = UIFont(name: "Lato", size: 14)
            self.challengePrize.font = UIFont(name: "Lato", size: 0)
            self.separatorA.hidden = true
            self.prizeIcon.hidden = true
            
            
        default: // rest of screen sizes
            break
        }

        self.tintBarUp(self.view)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        challengeFb.layer.masksToBounds = false

        challengeFb.clipsToBounds = true
        
        challengeFb.layer.cornerRadius = challengeFb.frame.height/5
        
        
        
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        ChallengeDAO.getChallengeforParse { (challenge, success) -> Void in
            if success{
                
                let chDescrition = challenge?.objectForKey("description") as! String
                let chTitle = challenge?.objectForKey("name") as! String
                
                let getImage = challenge?.objectForKey("image") as? PFFile
                if getImage != nil{
                    ImageDAO.getImageFromParse(getImage, ch: { (image, success) -> Void in
                        if success{
                            if image != nil {
                               self.challengeImage.image = image
                                
                            }else{
                                print("Nao tem imagem")
                                self.challengeImage.image = UIImage(named:"now-pouring")
                                // não tem imagem
                            }
                            
                        }else{
                            //erro ao obter imagem
                            self.challengeImage.image = UIImage(named:"now-pouring")
                        }
                    })
                }else{
                    print("imagem generica")
                    self.challengeImage.image = UIImage(named:"now-pouring")
                }

                

                
                self.challengeTitle.text = chTitle
                self.challengeDescription.text = chDescrition
                
            }else{
                self.challengeImage.image = UIImage(named:"now-pouring")
                //self.view.addSubself.self.view(challengeImage)
                
                self.challengeTitle.text = "Challenge"
                self.challengeDescription.text = "erro ao carregar"
            }
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func challengeFb(sender: UIButton){
        
        let fbURLWeb: NSURL = NSURL(string: "https://www.facebook.com/BeerLoveApp/?ref=hl")!
        
        UIApplication.sharedApplication().openURL(fbURLWeb)
    }
    
    
    
    
    
}


