//
//  PetDetailViewController.swift
//  PetFosterApp
//
//  Created by Niko Holbrook on 4/20/22.
//

import UIKit
import Parse
import AlamofireImage

class PetDetailViewController: UIViewController {
    
    var listing: PFObject!

    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailAgeLabel: UILabel!
    @IBOutlet weak var detailSpeciesLabel: UILabel!
    @IBOutlet weak var detailDescTitle: UILabel!
    @IBOutlet weak var detailDescLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let name = listing["name"] as! String
        detailNameLabel.text = name
        
        let age = listing["age"] as! Int
        detailAgeLabel.text = String(age) + " year(s)"
        detailSpeciesLabel.text = listing["species"] as? String
        
        detailDescTitle.text = "About " + name
        detailDescLabel.text = listing["description"] as? String
        
        detailDescLabel.sizeToFit()
        
        let imageFile = listing["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        detailImageView.af.setImage(withURL: url)
        

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
