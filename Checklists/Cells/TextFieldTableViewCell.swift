//
//  TextFieldTableViewCell.swift
//  Checklists
//
//  Created by Tim Nazar on 25.04.2022.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {
    @IBOutlet weak var addItemTextField: UITextField!
    
    var textFieldValueOnChange: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func textFieldDidChange(_ sender: UITextField) {
        if let text = sender.text {
            print(text)
            textFieldValueOnChange?(text)
        }
    }
}
