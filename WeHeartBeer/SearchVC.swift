//
//  SearchVC.swift
//  WeHeartBeer
//
//  Created by Fernando H M Bastos on 11/5/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import UIKit
import Parse
import ParseUI

//var brewery = [PFObject]()


class SearchVC: UIViewController, UISearchResultsUpdating, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate {
    
    @IBOutlet weak var resultsTable: UITableView!
    @IBOutlet weak var searchTypeText: UILabel!


    let controller = UISearchController(searchResultsController: nil)
    
    var searchResults: [Brewery] = [Brewery]()
    var searchActive: Bool = false
    var resultsList: NSArray!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      //  searchTypeText.hidden = false

        
        //setting delegates
        self.controller.searchResultsUpdater = self
        self.controller.dimsBackgroundDuringPresentation = false
        self.controller.searchBar.sizeToFit()
        self.controller.hidesNavigationBarDuringPresentation = false
        self.controller.delegate = self
        self.controller.searchBar.delegate = self
        self.definesPresentationContext = true
        
        //default text for search tab
        searchTypeText.text = "Faça sua pesquisa por Cervejas"
        searchTypeText.sizeToFit()
        
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
    
    func loadSearchResults(searchString: String){
        
        // let searchPredicate = NSPredicate(format: "SELF.name CONTAINS[c] %@", self.controller.searchBar.text!)
        
    }
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        
        // searchTypeText.hidden = true //hides default message
        controller.searchBar.showsCancelButton = true //enable cancel button
        controller.searchBar.hidden = false //keep search up
        
        resultsTable.reloadData() //reload data
        
        
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        
        controller.searchBar.showsCancelButton = false //dismiss cancel button
        controller.searchBar.resignFirstResponder() //dismiss keyboard
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        controller.searchBar.showsCancelButton = false //dismiss cancel button
        controller.searchBar.text = ""  //clears text field
        
        // Dismiss the keyboard
        controller.searchBar.resignFirstResponder()
        
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
        resultsTable.reloadData()
        //  searchTypeText.hidden = false //shows default text
        
        // Clear any search criteria
        controller.searchBar.text = ""
        
        // Dismiss the keyboard
        controller.searchBar.resignFirstResponder()
        
        //dismiss cancel button
        controller.searchBar.showsCancelButton = false
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.controller.active) {
            return self.searchResults.count
        } else {
            return 0
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell =  resultsTable.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ResultsTableViewCell
        //var objectRtn: PFObject = self.resultsList.objectAtIndex(indexPath.row) as! PFObject
        print(self.resultsList.objectAtIndex(indexPath.row).name)
        cell.resutLabel?.text = self.resultsList.objectAtIndex(indexPath.row).name
        
        
        return cell
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        var query = PFQuery(className: "Brewery").whereKey("name", containsString: controller.searchBar.text!.lowercaseString)
        query.findObjectsInBackgroundWithBlock { (results: [PFObject]?,error: NSError?) -> Void in
            
            if (error == nil) {
                self.searchResults.removeAll(keepCapacity: false)
                
                self.searchResults += results as! [Brewery]
                //print(self.searchResults)
                //                print(self.brewery[0].objectForKey("local") )
                self.resultsList = results
                self.resultsTable.reloadData()
                
            } else {
                // Log details of the failure
                print("search query error: \(error) \(error!.userInfo)")
            }
        }
    }
    //
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.resultsTable.cellForRowAtIndexPath(indexPath)
        performSegueWithIdentifier("segueSearch", sender: indexPath)
    }
    //
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueSearch"{
            if let destination = segue.destinationViewController  as? BeerProfileVC{
                if let indexPath = resultsTable.indexPathForSelectedRow?.row{  
                }
            }
        }
    }
    //
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //
}