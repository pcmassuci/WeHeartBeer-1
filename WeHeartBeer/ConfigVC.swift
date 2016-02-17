//
//  ConfigVC.swift
//  BeerLove
//
//  Created by Fernando H M Bastos on 1/12/16.
//  Copyright © 2016 Fernando H M Bastos. All rights reserved.
//

import Foundation
import UIKit

class ConfigVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row{
        case 2:
            UserDAO.logout({ (success) -> Void in
                self.alert("Atenção", message: "Você deslogou do Facebook", option: false, action: nil)
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
            })
            break
        default:
            break
        }
    }
    
    
}

