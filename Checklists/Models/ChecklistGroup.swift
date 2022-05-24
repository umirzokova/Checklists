//
//  ChecklistGroup.swift
//  Checklists
//
//  Created by Tim Nazar on 18.04.2022.
//

import Foundation

struct ChecklistGroup {
    let title: String
    let imageName: String
    var items: [ChecklistItem]
    
    func getRemainings() -> String {
        //TO DO
        //1. All Done
        var isAllDone = true
        for item in items {
            if item.isChecked == false {
                isAllDone = false
            }
        }
        
        if items.isEmpty {
            return "(No items)"
        } else if !isAllDone, items.count != 0 {
            return "\(items.count) Remaining"
        }
        if isAllDone {
            return "All Done"
        } else {
            return "Incorrect data"
        }
    }
}
