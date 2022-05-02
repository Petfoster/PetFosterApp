//
//  SearchTableViewController.swift
//  PetFosterApp
//
//  Created by Nick Flores on 4/26/22.
//

import UIKit
import Parse
import AlamofireImage


class SearchTableViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    

    let searchController  = UISearchController()
    var listings = [PFObject]()
    
    let myRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadListings()
        initSearchController()
    }
    func initSearchController(){
            searchController.loadViewIfNeeded()
            searchController.searchResultsUpdater = self
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.enablesReturnKeyAutomatically = false
            searchController.searchBar.returnKeyType = UIReturnKeyType.done
            definesPresentationContext = true
            
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = true
            searchController.searchBar.scopeButtonTitles = ["All", "Dog", "Rabbit", "Cat"]
            searchController.searchBar.delegate = self
        }
    
    func loadListings(){
        let query = PFQuery(className: "Listing")
        query.includeKeys(["name", "age", "species", "author", "comments", "comments.author"])
        query.findObjectsInBackground{ (posts, error) in
            if posts != nil {
                self.listings = posts!
                self.myRefreshControl.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }

    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let searchText = searchBar.text!
        
        getPets(scopeButton: scopeButton)
        
    }
    
    func getPets(scopeButton: String){
        
        let query = PFQuery(className:"Listing")
        if(scopeButton ==  "All"){
            self.loadListings()
        }else{
            query.whereKey("species", contains: scopeButton)
            query.includeKeys(["name", "age", "species", "author", "comments", "comments.author"])
            query.findObjectsInBackground { lists, error in
                self.listings  = lists!
                self.myRefreshControl.endRefreshing()
                self.tableView.reloadData()
            }
        }
        self.myRefreshControl.endRefreshing()
        self.tableView.reloadData()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return listings.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let listing = listings[indexPath.section]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as! SearchTableViewCell
        
        let petName = listing["name"] as! String
        cell.nameLabel.text = petName
    
        let species = listing["species"] as! String
        
        cell.speciesLabel.text! = "Species: " + species
        
        let age = listing["age"] as! Int
        
        cell.ageLabel.text = "Age: " + String(age) + " year(s)"
        
        let imageFile = listing["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.picView.af.setImage(withURL: url)
        
        return cell
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for:cell)!
        let listing = listings[indexPath.section]
        
        let detailsViewController = segue.destination as! PetDetailViewController
        detailsViewController.listing = listing
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }


}

