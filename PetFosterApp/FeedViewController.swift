//
//  FeedViewController.swift
//  PetFoster
//
//  Created by Nick Flores on 4/11/22.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var listings = [PFObject]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self;
        tableView.dataSource = self;
//        let listing = PFObject(className: "Listing")
//        listing["author"] = "Nick"
//        listing["name"] = "Buddy"
//        listing["age"] = 1
//        listing["species"] = "Dog"
//        listing["claimedBy"] = "Jose"
//        listing.saveInBackground { success, error in
//            if success{
//                print("saved!")
//            }else{
//                print("error!")
//            }
        }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className:"Listing")
        query.order(byDescending: "datePosted")
        query.findObjectsInBackground { (listings: [PFObject]?, error: Error?) in if let error = error {
                print(error.localizedDescription)
            }else if let listings = listings {
                print("Successfully retrieved \(listings.count) listings.")
            }
        }
    }
    
        // Do any additional setup after loading the view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listings.count;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListingCell")
        as!ListingCell
        
        //let listing = listings[indexPath.row]
        //TODO: author should point at USER!! RN it is a string
        //let user = listing["author"] as! PFUser
        // cell.petNameLabel.text = listing
        
        return cell
    }
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

