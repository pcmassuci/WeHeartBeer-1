//
//  MoreVC.swift
//  BeerLove
//
//  Created by Fernando H M Bastos on 1/12/16.
//  Copyright © 2016 Fernando H M Bastos. All rights reserved.
//

import Foundation
import UIKit

class MoreVC: UIViewController {
    
    @IBOutlet weak var optionsMore: UITableView!
    @IBOutlet weak var titleMore: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255.0/255.0, green: 192.0/255.0, blue: 3.0/255.0, alpha: 1.0)
        
    }
    
    

}
