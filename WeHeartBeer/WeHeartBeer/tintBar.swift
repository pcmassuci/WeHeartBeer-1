//
//  tintBar.swift
//  BeerLove
//
//  Created by Fernando H M Bastos on 2/7/16.
//  Copyright © 2016 Fernando H M Bastos. All rights reserved.
//

import UIKit
import Foundation

class tintBar: UIViewController {

    class func tintBarUp (view: UIView) -> Void{
    
        let view2 = UIView(frame:
            CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: UIApplication.shared.statusBarFrame.size.height)
        )
        view2.backgroundColor = UIColor(red: 250.0/255.0, green: 170.0/255.0, blue: 4.0/255.0, alpha: 1.0)
        
        view.addSubview(view2)
    
    }
    
}
