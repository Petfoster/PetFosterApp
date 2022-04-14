//
//  ListingCell.swift
//  PetFosterApp
//
//  Created by Nick Flores on 4/13/22.
//

import UIKit

class ListingCell: UITableViewCell {

    @IBOutlet weak var petNameLabel: UILabel!
    
    @IBOutlet weak var petImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
