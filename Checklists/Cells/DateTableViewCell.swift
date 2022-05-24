//
//  DateTableViewCell.swift
//  Checklists
//
//  Created by Tim Nazar on 25.04.2022.
//

import UIKit

class DateTableViewCell: UITableViewCell {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var onDateValueChange: ((Date) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didChangeDate(_ sender: UIDatePicker) {
        print(sender.date)
        onDateValueChange?(sender.date)
    }
}
