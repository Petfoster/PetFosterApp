//
//  CommentCell.swift
//  PetFosterApp
//
//  Created by Niko Holbrook on 4/25/22.
//

import UIKit

class CommentCell: UITableViewCell {
    
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
