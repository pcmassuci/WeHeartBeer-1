//
//  SearchBreweryVC.swift
//  BeerLove
//
//  Created by Paulo César Morandi Massuci on 02/12/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class SearchBreweryVC: UIViewController {

        
        
        @IBOutlet weak var resultsTable: UITableView!
        //@IBOutlet weak var searchTypeText: UILabel!
        
    
        let controller = UISearchController(searchResultsController: nil)
        var currentObject: PFObject?
        //Creates class object and aux array for
        var searchResults: [Brewery] = [Brewery]()
        var resultsList: NSArray!
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.controller.searchBar.barTintColor = UIColor(red: 0.16, green: 0.68, blue: 0.62, alpha: 1.0)
            self.controller.searchBar.tintColor = UIColor(white: 1, alpha: 1)
            
            let view: UIView = self.controller.searchBar.subviews[0]
            let subViewsArray = view.subviews
            
            
            //setting delegates
            self.controller.searchResultsUpdater = self
            self.controller.dimsBackgroundDuringPresentation = false
            self.controller.searchBar.sizeToFit()
            self.controller.hidesNavigationBarDuringPresentation = false
            self.controller.delegate = self
            self.controller.searchBar.delegate = self
            self.definesPresentationContext = true


            // default text for search tab
            // searchTypeText.text = "Faça sua pesquisa por Cervejas"
            // searchTypeText.sizeToFit()
            
            //creates a search bar as header for the table view
            self.resultsTable.tableHeaderView = self.controller.searchBar
            
            //yay, more delegates...
            resultsTable.delegate = self
            resultsTable.dataSource = self
            
            //load results table
            resultsTable.hidden = false
            self.resultsTable.reloadData()
            resultsTable.tableFooterView = UIView()
            
            
            // Do any additional setup after loading the view.
        }
        
        override func viewWillAppear(animated: Bool) {
            super.viewWillAppear(animated)
            //Hide NavigationController
            self.navigationController?.navigationBar.hidden = false
            controller.searchBar.resignFirstResponder()
        }
        
    
        // Memory Warning
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
//MARK: -Prepare segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueAddBeer"{
            if let destination = segue.destinationViewController  as?  AddBeer  {
              if let indexPath = resultsTable.indexPathForSelectedRow?.row{
                   let row = Int(indexPath)
                    destination.brewery = (self.resultsList[row]) as? Brewery
                }
            }
        }
    }
}

        
    
    
//MARK: TableView Methods
extension SearchBreweryVC:   UITableViewDelegate, UITableViewDataSource{
    
      // Sets number of rows in tableview
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Must ensure the controler is active and the array of results is not nil
        if (self.controller.active && self.resultsList != nil) {
            var count = self.resultsList.count
            count += 1
            return count
        }
            
        else {
            return 0
        }
    }
    
    // Number of sections in tableview - not used
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //Sets the tableview cell and change its info to the correspondent object
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell =  resultsTable.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! SearchTVCell
        
        let count = self.resultsList.count
        if indexPath.row < count{
            
            //Debug
            //print(self.resultsList.objectAtIndex(indexPath.row).name)
            //print(resultsList)
            cell.BreweryName?.text = self.resultsList.objectAtIndex(indexPath.row).objectForKey("name") as? String
            
          
        }
            
        else{
            
            cell.BreweryName?.text = "Adicione Cervejaria"
        }
        
        return cell
    }
    
    
    // Perform segue - WIP (redundancia com o prepareForSegue
        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            if indexPath.row < self.resultsList.count {
                performSegueWithIdentifier("segueAddBeer", sender: indexPath)}
            else if indexPath.row == self.resultsList.count {
                performSegueWithIdentifier("segueCreateBrew", sender: indexPath)
            }
        }
    
    
    
}

//MARK: Search Methods
extension SearchBreweryVC: UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate{
    
       //behaviour when search starts
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        
        // searchTypeText.hidden = true //hides default message
        controller.searchBar.showsCancelButton = true //enable cancel button
        controller.searchBar.hidden = false //keep search up
        
        resultsTable.reloadData() //reload data
        
        
    }
    
    // stop editing behaviour
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        
        controller.searchBar.showsCancelButton = false //dismiss cancel button
        controller.searchBar.resignFirstResponder() //dismiss keyboard
    }
    
    // Search button clicked
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        controller.searchBar.showsCancelButton = false //dismiss cancel button
                
        // Dismiss the keyboard
        controller.searchBar.resignFirstResponder()
        
        self.resultsTable.reloadData()
        
        
        
    }
    
    // Cancel button clicked
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
        //  searchTypeText.hidden = false //shows default text
        
        // Clear any search criteria
        controller.searchBar.text = ""
        
        // Dismiss the keyboard
        controller.searchBar.resignFirstResponder()
        
        // Dismiss cancel button
        controller.searchBar.showsCancelButton = false
        
        // Clears the results list array for a new search
        self.resultsList = nil
        
        self.resultsTable.reloadData()
    }
    
    //Update controller as it changes
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        // To avoid querying results based on one or two letters
        if(controller.searchBar.text?.characters.count > 2){
            
            // Query objects matching their names with text imput - regex for case insensitivity
            let query = PFQuery(className: "Brewery").whereKey("name", matchesRegex: controller.searchBar.text!, modifiers: "i")
            
            // Alphabetical order
            query.orderByAscending("name")
            
            // Get query objects and save them in resultsList array
            query.findObjectsInBackgroundWithBlock { (results: [PFObject]?,error: NSError?) -> Void in
                
                if (error == nil) {
                    
                    self.resultsList = results
                    self.resultsTable.reloadData()
                    
                } else {
                    // Log details of the failure
                    print("search query error: \(error) \(error!.userInfo)")
                    
                }
            }
        }
        else { // If the user taps the clear button or erase the text imput
            
            if(self.controller.searchBar.text == "" ){
                self.resultsList = nil // Clean Query
                self.resultsTable.reloadData()
            }
        }
    }



}
