//
//  AddItemTableViewController.swift
//  Checklists
//
//  Created by Tim Nazar on 25.04.2022.
//

import UIKit

class AddItemTableViewController: UITableViewController {
    
    var item: ChecklistItem?
    var textFieldValue: String = ""
    var switchValue: Bool = false
    var dueDateValue: Date?
    var groupTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if let item = item {
            if item.remindMe {
                return 3
            } else {
                return 2
            }
        } else {
            return 3
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! TextFieldTableViewCell
            if let item = item {
                cell.addItemTextField.text = item.name
            }
            cell.textFieldValueOnChange = { (text: String) -> Void in
                print("ya poluchila \(text)")
                self.textFieldValue = text
            }

            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell", for: indexPath) as! SwitchTableViewCell
            cell.switchRemind.setOn(item?.remindMe ?? false, animated: true)
            cell.onSwitchChanged = { (value: Bool) in
                print("я внутри клоужера")
                self.switchValue = value
                print("ya poluchila \(value)")
                self.item?.remindMe = cell.switchRemind.isOn
                tableView.reloadData()
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath) as! DateTableViewCell
            if let item = item, let date = item.dueDate {
                cell.datePicker.setDate(date, animated: true)
            }
            cell.onDateValueChange = { (date: Date) -> Void in
                self.dueDateValue = date
            }
            return cell
        }
    }
    
    @IBAction func didTapDoneButton(_ sender: Any) {
        let newitem = ChecklistItem(isChecked: false, name: textFieldValue, remindMe: switchValue, dueDate: dueDateValue)
        let object: (ChecklistItem, String) = (newitem, groupTitle ?? "нет категорий")
        NotificationCenter.default.post(name: .noteHasBeenCreated, object: object)
        print(newitem)
        navigationController?.popToRootViewController(animated: true)
    }
    // Создать object - тип объекта Tuple: (ChecklistItem,  String)
    // Заполнить объект - забрать у компонентов(ячеек) их значения
    // Передать через нотификацию при нажатии на кнопочку "Done" - ChecklistItem и groupName
    // Обработать данные на первом экране - 
    //
}
