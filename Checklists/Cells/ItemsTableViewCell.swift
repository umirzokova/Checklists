//
//  ItemsTableViewCell.swift
//  Checklists
//
//  Created by Tim Nazar on 22.04.2022.
//

import UIKit

class ItemsTableViewCell: UITableViewCell {
    @IBOutlet weak var checkMarkIcon: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
