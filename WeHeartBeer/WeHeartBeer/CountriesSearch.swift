//
//  CountriesSearch.swift
//  BeerLove
//
//  Created by Paulo César Morandi Massuci on 09/12/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import UIKit

protocol CountriesSearchDelegate{
//    func country(nameCountry:String?)
}

class CountriesSearch: UITableViewController {
//    var delegate: CountriesSearchDelegate?
//    var countries: [String] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.tintBarUp(view: self.view)
//        self.navigationController?.navigationBar.isHidden = false
//        
//        self.navigationController?.navigationBar.barTintColor = UIColor(red: 250.0/255.0, green: 170.0/255.0, blue: 0.0/255.0, alpha: 1.0)
//        self.navigationController?.navigationBar.tintColor = UIColor.white
//
//        
//        var aux: [String] = []
//        for code in NSLocale.isoCountryCodes as [String] {
//            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
//            let name = NSLocale(localeIdentifier: "pt_BR").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
//            aux.append(name)
//        }
//        self.countries = aux.sorted()
//
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//
//        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    // MARK: - Table view data source
//
//     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return self.countries.count
//    }
//
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell =  tableView.dequeueReusableCell(withIdentifier: "coutryCell", for: indexPath as IndexPath) as! CountryCell
//
//        cell.countryLabel.text = self.countries[indexPath.row]
//        // Configure the cell...
//
//        return cell
//    }
//    
//     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        delegate?.country(nameCountry: self.countries[indexPath.row])
//            if let navController = self.navigationController {
//                navController.popViewController(animated: true)
//            }else{
//                
//                print("optional value")  
//            }
//      
//       
//    }
//
//    
}
