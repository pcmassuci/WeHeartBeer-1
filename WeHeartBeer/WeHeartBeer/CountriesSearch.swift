//
//  CountriesSearch.swift
//  BeerLove
//
//  Created by Paulo César Morandi Massuci on 09/12/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import UIKit

protocol CountriesSearchDelegate{
    func country(nameCountry:String?)
}

class CountriesSearch: UITableViewController {
    var delegate: CountriesSearchDelegate?
    var countries: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var aux: [String] = []
        for code in NSLocale.ISOCountryCodes() as [String] {
            let id = NSLocale.localeIdentifierFromComponents([NSLocaleCountryCode: code])
            let name = NSLocale(localeIdentifier: "pt_BR").displayNameForKey(NSLocaleIdentifier, value: id) ?? "Country not found for code: \(code)"
            aux.append(name)
        }
        self.countries = aux.sort()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.countries.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCellWithIdentifier("coutryCell", forIndexPath: indexPath) as! CountryCell

        cell.countryLabel.text = self.countries[indexPath.row]
        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            delegate?.country(self.countries[indexPath.row])
            if let navController = self.navigationController {
                navController.popViewControllerAnimated(true)
            }else{
                
                print("optional value")  
            }
      
       
    }

    
}
