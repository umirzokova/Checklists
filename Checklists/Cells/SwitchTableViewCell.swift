//
//  RemindTableViewCell.swift
//  Checklists
//
//  Created by Tim Nazar on 25.04.2022.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {

    var onSwitchChanged: ((Bool) -> Void)?
    
    @IBOutlet weak var switchRemind: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func switchDidChange(_ sender: UISwitch) {
        print("значение свитча: \(sender.isOn)")
        onSwitchChanged?(sender.isOn)
    }
}
