//
//  GroupDetailsTableViewController.swift
//  Checklists
//
//  Created by Tim Nazar on 22.04.2022.
//

import UIKit

// TODO:
// 1. Создать массив с нашими данными
// 2.


class GroupDetailsTableViewController: UITableViewController {
    
    var group: ChecklistGroup!
    var delegate: GroupDetailsProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return group.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = group.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItemCell", for: indexPath) as! ItemsTableViewCell
        cell.itemLabel.text = item.name
        cell.checkMarkIcon.isHidden = !item.isChecked
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GroupDetailsToAddItem",
           let vc = segue.destination as? AddItemTableViewController,
           let indexpath = tableView.indexPathForSelectedRow {
            vc.title = "Edit item"
            vc.item = group.items[indexpath.row]
            //items[indexpath.row].name
        }
        
        if segue.identifier == "JumpToAddNewNote",
           let vc = segue.destination as? AddItemTableViewController {
            vc.groupTitle = group.title
        }
    }
    
    // MARK: - обработка делегата таблицы или UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("тапнули на клетку \(indexPath.row)")
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        // удаляем данные из массива
        group.items.remove(at: indexPath.row)

        // удалить ячейку из самой таблицы
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        // 
        delegate?.didDeleteItem(at: indexPath.row, with: group.title)
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
