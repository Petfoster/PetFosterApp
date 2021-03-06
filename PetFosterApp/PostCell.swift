//
//  PostCell.swift
//  PetFosterApp
//
//  Created by Alexis Sanchez on 4/15/22.
//

import Foundation
import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var petNameLabel: UILabel!
    

    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var speciesLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
