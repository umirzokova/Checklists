//
//  ViewController.swift
//  Checklists
//
//  Created by Tim Nazar on 15.04.2022.
//

import UIKit

class MainViewController: UITableViewController, GroupDetailsProtocol {
    
    // MARK: - GroupDetailsProtocol
    func didDeleteItem(at index: Int, with groupTitle: String) {
        for (groupIndex, group) in groups.enumerated() {
            if group.title == groupTitle {
                groups[groupIndex].items.remove(at: index)
                tableView.reloadData()
            }
        }
    }
    
    
    // MARK: - мои данные
    var groups: [ChecklistGroup] = [
        ChecklistGroup(title: "Birthdays", imageName: "Birthdays", items: [
            ChecklistItem(isChecked: true, name: "Congratulate Nargiz", remindMe: false, dueDate: nil),
            ChecklistItem(isChecked: false, name: "Congratulations", remindMe: true, dueDate: Date())
        ]),
        ChecklistGroup(title: "Chores", imageName: "Chores", items: [
            ChecklistItem(isChecked: true, name: "Wash clothes", remindMe: false)
        ]),
        ChecklistGroup(title: "Groceries", imageName: "Groceries", items: []),
        ChecklistGroup(title: "To Do", imageName: "Inbox", items: [
            ChecklistItem(isChecked: true, name: "Learn Swift", remindMe: false)
        ])
    ]
    
    // MARK: - Жизненный цикл View controller-a
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Подписываемся на нотификацию о создании заметки
        NotificationCenter.default.addObserver(self, selector: #selector(handleAddNoteNotification), name: .noteHasBeenCreated, object: nil)
    }
    
    @objc
    func handleAddNoteNotification(_ notification: Notification) {
        if let object = notification.object as? (ChecklistItem, String) {
            print("обрабатываю добавление новой заметки")
            print("Получил значение: \(object.1)")
            for (index, group) in groups.enumerated() {
                if group.title == object.1 {
//                    group.items.append(object.0)
                    groups[index].items.append(object.0)
                    tableView.reloadData()
                    print(group.items)
                }
            }
        }
    }
    
    
    // MARK: - источник данных для таблицы
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let group = groups[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupTableViewCell
        cell.titleLabel.text = group.title
        cell.iconView.image = UIImage(named: group.imageName)
        cell.subtitleLabel.text = group.getRemainings()
        return cell
    }
    
    // MARK: - обработка segue(перехода)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*if segue.identifier == "MainToGroupDetails" {
            print("send info")
            if let vc = segue.destination as? GroupDetailsTableViewController {
                vc.items = [
                    ChecklistItem(isChecked: true, name: "To do")
                ]
            }
        }
    }*/
        if segue.identifier == "MainToGroupDetails",
           let vc = segue.destination as? GroupDetailsTableViewController,
           let indexpath = tableView.indexPathForSelectedRow {
            vc.title = groups[indexpath.row].title
            vc.group = groups[indexpath.row]
            vc.delegate = self
        }
    }
    
    // MARK: - обработка делегата таблицы или UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("тапнули на клетку \(indexPath.row)")
    }
}
