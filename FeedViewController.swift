//
//  FeedViewController.swift
//  PetFoster
//
//  Created by Nick Flores on 4/11/22.
//

import UIKit
import Parse

class FeedViewController: UIViewController {
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let listing = PFObject(className: "Listing")
        listing["author"] = "Nick"
        listing.saveInBackground { success, error in
            if success{
                print("saved!")
            }else{
                print("error!")
            }
        }
        // Do any additional setup after loading the view.
        }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
