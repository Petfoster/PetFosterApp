//
//  FeedViewController.swift
//  PetFoster
//
//  Created by Nick Flores on 4/11/22.
//

import UIKit
import Parse

import UIKit
import Parse
import AlamofireImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var listings = [PFObject]()
    @IBOutlet weak var tableView: UITableView!
    var selectedPost: PFObject!
    var numberOfListings: Int!
    
    let myRefreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        numberOfListings = 20
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .interactive
        
        
        myRefreshControl.addTarget(self, action: #selector(loadListings), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
        
        loadListings()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadListings()
    }
    
    @objc func loadListings() {
        let query = PFQuery(className: "Listing")
        query.includeKeys(["name", "age", "species", "author", "comments", "comments.author"])
        query.limit = numberOfListings
        query.findObjectsInBackground{ (posts, error) in
            if posts != nil {
                self.listings = posts!
                self.myRefreshControl.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        PFUser.logOut()
        let main = UIStoryboard (name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else { return }
        
        delegate.window?.rootViewController = loginViewController
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listings.count
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listing = listings[indexPath.section]
        
            //Main Post Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
            let petName = listing["name"] as! String
            cell.petNameLabel.text = petName
        
            let species = listing["species"] as! String
            
            cell.speciesLabel.text! = "Species: " + species
            
            let age = listing["age"] as! Int
            
            cell.ageLabel.text = "Age: " + String(age) + " year(s)"
            
            let imageFile = listing["image"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            
            cell.photoView.af.setImage(withURL: url)
            
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
