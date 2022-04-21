//
//  SearchViewController.swift
//  PetFosterApp
//
//  Created by Nick Flores on 4/20/22.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var speciesMenu: UIPickerView!
    
    @IBOutlet weak var ageText: UITextField!
    
    @IBOutlet weak var distanceMenu: UIPickerView!
    
    
    @IBAction func searchButton(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
