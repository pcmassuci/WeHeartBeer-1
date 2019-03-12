//
//  SearchVC.swift
//  WeHeartBeer
//
//  Created by Fernando H M Bastos on 11/5/15.
//  Copyright © 2015 Fernando H M Bastos. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
//
//
//
//
//    @IBOutlet weak var initialLabel: UILabel!
//    @IBOutlet weak var initialImage: UIImageView!
//    @IBOutlet weak var resultsTable: UITableView!
//    @IBOutlet weak var name: UILabel!
//
//    @IBOutlet weak var beerStyle: UILabel!
//    let controller = UISearchController(searchResultsController: nil)
//
//    //Creates class object and aux array for
//    var searchResults: [Beer] = [Beer]()
//    var resultsList: NSArray!
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.controller.searchBar.barTintColor = UIColor(red: 250.0/255.0, green: 170.0/255.0, blue: 0.0/255.0, alpha: 1.0)
//        self.controller.searchBar.tintColor = UIColor(white: 1, alpha: 1)
//        controller.searchBar.subviews[0].subviews.flatMap(){ $0 as? UITextField }.first?.tintColor = UIColor(red: 250.0/255.0, green: 170.0/255.0, blue: 0.0/255.0, alpha: 1.0)
//
//
//        let view: UIView = self.controller.searchBar.subviews[0]
//        _ = view.subviews
//
//        initialImage.isHidden = false
//        initialLabel.hidden = false
//        initialLabel.text = "Aqui você pode procurar e adicionar cervejas no nosso banco de dados!"
//
//        let screenHeight = UIScreen.mainScreen().bounds.height
//        print(screenHeight)
//
//        switch screenHeight {
//        case 480:
//
//            self.initialLabel.font = UIFont(name: "Lato", size: 14)
//
//
//        default: // rest of screen sizes
//            break
//        }
//
//
//
//        let view2 = UIView(frame:
//            CGRect(x: 0.0, y: 0.0, width: UIScreen.mainScreen().bounds.size.width, height: UIApplication.sharedApplication().statusBarFrame.size.height)
//        )
//        view2.backgroundColor = UIColor(red: 250.0/255.0, green: 170.0/255.0, blue: 4.0/255.0, alpha: 1.0)
//
//        self.view.addSubview(view2)
//
//
//        self.navigationController?.navigationBar.barTintColor = UIColor(red: 250.0/255.0, green: 170.0/255.0, blue: 0.0/255.0, alpha: 1.0)
//
//
//
//
//        //setting delegates
//        self.controller.searchResultsUpdater = self
//        self.controller.dimsBackgroundDuringPresentation = false
//        self.controller.searchBar.sizeToFit()
//        self.controller.hidesNavigationBarDuringPresentation = false
//        self.controller.delegate = self
//        self.controller.searchBar.delegate = self
//        self.definesPresentationContext = true
//
//        // default text for search tab
//        // searchTypeText.text = "Faça sua pesquisa por Cervejas"
//        // searchTypeText.sizeToFit()
//
//        //creates a search bar as header for the table view
//        self.resultsTable.tableHeaderView = self.controller.searchBar
//
//        //yay, more delegates...
//        resultsTable.delegate = self
//        resultsTable.dataSource = self
//
//        //load results table
//        resultsTable.hidden = false
//        self.resultsTable.reloadData()
//        resultsTable.tableFooterView = UIView()
//
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        //Hide NavigationController
//        self.navigationController?.navigationBar.hidden = true
//
//       // self.controller.searchBar.text = ""
//        controller.searchBar.resignFirstResponder()
//
//
//    }
//
//
//
//    // Prepare segue - WIP
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "segueSearch"{
//            if let destination = segue.destinationViewController  as? BeerProfileVC{
//                if let indexPath = resultsTable.indexPathForSelectedRow?.row{
//
//                    let row = Int(indexPath)
//                    destination.currentObject = (self.resultsList[row]) as? PFObject
//
//                }
//            }
//        }
//    if segue.identifier == "segueFoundBrewery" {
//
//
//        }
//    }
//
//
//    // MARK: - Memory Warning
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//}
//
//// MARK: - TableView Methods
//
//extension SearchVC: UITableViewDelegate, UITableViewDataSource{
//
//
//
//
//    //        Perform segue - WIP
//        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//            //let cell = self.resultsTable.cellForRowAtIndexPath(indexPath)
//            if indexPath.row < self.resultsList.count {
//                performSegueWithIdentifier("segueSearch", sender: indexPath)}
//            else if indexPath.row == self.resultsList.count {
//                if UserServices.loggedUser(){
//                performSegueWithIdentifier("segueFoundBrewery", sender: indexPath)
//                }else{
//                    self.tabBarController?.selectedIndex = 2
//                }
//            }
//
//            resultsTable.deselectRowAtIndexPath(indexPath, animated: true)
//        }
//
//    // Sets number of rows in tableview
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        // Must ensure the controler is active and the array of results is not nil
//        if (self.controller.active && self.resultsList != nil) {
//            var count = self.resultsList.count
//            count += 1
//
//
//            return count
//
//
//        }
//
//        else {
//
//            return 0
//        }
//    }
//
//    // Number of sections in tableview - not used
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//
//    //Sets the tableview cell and change its info to the correspondent object
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//
//        let cell =  resultsTable.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ResultsTableViewCell
//
//
//
//        let count = self.resultsList.count
//        if indexPath.row < count{
//
//            cell.backgroundColor = UIColor.whiteColor()
//            //Debug
//            //print(self.resultsList.objectAtIndex(indexPath.row).name)
//            //print(resultsList)
//
//            cell.resutLabel?.text = self.resultsList.objectAtIndex(indexPath.row).objectForKey("name") as? String
//
//            cell.brewery?.text = self.resultsList.objectAtIndex(indexPath.row).objectForKey("brewName")! as? String
//
//            let styleTemp = self.resultsList.objectAtIndex(indexPath.row).objectForKey("Style") as! String
//
//            cell.beerStyle?.text = "Estilo: \(styleTemp) "
//
//
//            if self.resultsList.objectAtIndex(indexPath.row).objectForKey("Photo") != nil{
//                let imageBeer = resultsList.objectAtIndex(indexPath.row).objectForKey("Photo") as! PFFile
//                ImageDAO.getImageFromParse(imageBeer, ch: { (image, success) -> Void in
//                    if success{
//
//                        cell.searchImage.layer.borderWidth = 1
//                        cell.searchImage.layer.masksToBounds = false
//                        cell.searchImage.layer.borderColor = UIColor.blackColor().CGColor
//                        cell.searchImage.layer.cornerRadius = 40
//                        cell.searchImage.clipsToBounds = true
//
//                        cell.searchImage.image = image
//
//                    }else{
//                        cell.layoutIfNeeded()
//
//                        cell.searchImage.image = UIImage(named:"DefaultBeer.png")
//
//                        cell.searchImage.layer.borderWidth = 1
//                        cell.searchImage.layer.masksToBounds = false
//                        cell.searchImage.layer.borderColor = UIColor.blackColor().CGColor
//                        cell.searchImage.clipsToBounds = true
//                        cell.searchImage.layer.cornerRadius = cell.searchImage.frame.height/2
//
//                    }
//                })
//
//            }else{
//                cell.layoutIfNeeded()
//
//                cell.searchImage.image = UIImage(named:"DefaultBeer.png")
//
//                cell.searchImage.layer.borderWidth = 1
//                cell.searchImage.layer.masksToBounds = false
//                cell.searchImage.layer.borderColor = UIColor.blackColor().CGColor
//                cell.searchImage.clipsToBounds = true
//                cell.searchImage.layer.cornerRadius = cell.searchImage.frame.height/2
//            }
//
//           // cell.searchImage.image = self.resultsList.objectAtIndex(indexPath.row).
//
//            cell.addBeerLabel.hidden = true
//
//            cell.resutLabel.hidden = false
//
//            cell.brewery.hidden = false
//
//            cell.beerStyle.hidden = false
//
//        }
//
//        else{
//
//            cell.resutLabel.hidden = true
//
//            cell.brewery.hidden = true
//
//            cell.beerStyle.hidden = true
//
//            cell.addBeerLabel.hidden = false
//
//            cell.backgroundColor = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 0.8)
//
//            cell.searchImage.layer.borderWidth = 0
//            cell.searchImage.layer.masksToBounds = false
//            cell.searchImage.layer.cornerRadius = 0
//            cell.searchImage.clipsToBounds = true
//
//
//            cell.searchImage.image = UIImage(named:"cerva_add")
//
//            cell.addBeerLabel?.text = "Não achou a cerveja que estava procurando? Você pode adicioná-la agora!"
//        }
//
//        return cell
//    }
//
//}
//
//// MARK: - Search Methods
//
//extension SearchVC:  UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate{
//    //behaviour when search starts
//    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
//
//        initialImage.hidden = true
//        initialLabel.hidden = true
//
//
//        // searchTypeText.hidden = true //hides default message
//        controller.searchBar.showsCancelButton = true //enable cancel button
//        controller.searchBar.hidden = false //keep search up
//
//        resultsTable.reloadData() //reload data
//
//
//    }
//
//    // stop editing behaviour
//    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
//
//
//        controller.searchBar.showsCancelButton = false //dismiss cancel button
//        controller.searchBar.resignFirstResponder() //dismiss keyboard
//    }
//
//    // Search button clicked
//    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
//
//        if self.controller.searchBar.text == "" {
//            initialImage.hidden = false
//            initialLabel.hidden = false
//        }
//        controller.searchBar.showsCancelButton = false //dismiss cancel button
//        //controller.searchBar.text = ""  //clears text field
//
//        // Dismiss the keyboard
//        controller.searchBar.resignFirstResponder()
//
//
//       self.resultsTable.reloadData()
//
//
//
//    }
//
//    // Cancel button clicked
//    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
//
//        //  searchTypeText.hidden = false //shows default text
//
//
//        initialImage.hidden = false
//        initialLabel.hidden = false
//
//        // Clear any search criteria
//        controller.searchBar.text = ""
//
//        // Dismiss the keyboard
//        controller.searchBar.resignFirstResponder()
//
//        // Dismiss cancel button
//        controller.searchBar.showsCancelButton = false
//
//        // Clears the results list array for a new search
//        self.resultsList = nil
//
//        self.resultsTable.reloadData()
//    }
//
//
//    //Update controller as it changes
//    func updateSearchResultsForSearchController(searchController: UISearchController) {
//
//        // To avoid querying results based on one or two letters
//        if(controller.searchBar.text?.characters.count > 2){
//
//            // Query objects matching their names with text imput - regex for case insensitivity
//            let query = PFQuery(className: "Beer").whereKey("name", matchesRegex: controller.searchBar.text!, modifiers: "i")
//
//            // Alphabetical order
//            query.orderByAscending("name")
//
//            // Get query objects and save them in resultsList array
//            query.findObjectsInBackgroundWithBlock { (results: [PFObject]?,error: NSError?) -> Void in
//
//                if (error == nil) {
//
//                    self.resultsList = results
//                    self.resultsTable.reloadData()
//
//                } else {
//                    // Log details of the failure
//                    print("search query error: \(error) \(error!.userInfo)")
//
//                }
//            }
//        }
//        else { // If the user taps the clear button or erase the text imput
//
//            if(self.controller.searchBar.text == "" ){
//                self.resultsList = nil // Clean Query
//                self.resultsTable.reloadData()
//            }
//        }
//    }
//
//
}
