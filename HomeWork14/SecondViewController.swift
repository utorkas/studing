//
//  SecondViewController.swift
//  HomeWork14
//
//  Created by Сергей Кузнецов on 19.05.2020.
//  Copyright © 2020 Сергей Кузнецов. All rights reserved.
//

import UIKit
import CoreData

class SecondViewController: UIViewController {
    
    
    @IBOutlet weak var toDoTableView: UITableView!
  
    @IBAction func addTask(_ sender: Any) {
        self.alert(title: "Добавить задачу", message: "Введите название задачи", style: .alert)
    }
    func alert( title: String, message: String, style: UIAlertController.Style){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        let action = UIAlertAction(title: "Добавить", style: .default) { (action) in
            let text = alertController.textFields?.first?.text
            saveData(name: text!, isDone: false)
            self.toDoTableView.reloadData() }
        
        let cancelButton = UIAlertAction(title: "Отменить", style: .cancel)
        
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(action)
        alertController.addAction(cancelButton)
        
        self.present(alertController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveData()
    }
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell") as! TableViewCell
        let model = task[indexPath.row]
        cell.nameTaskCoreData.text = model.value(forKey: "name") as? String
        if (model.value(forKey: "isDone") as? Bool) == true {
            cell.accessoryType = .checkmark }
        else { cell.accessoryType = .none }
        
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeData(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade) }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        toDoTableView.deselectRow(at: indexPath, animated: true)
        changeData(at: indexPath.row)
        toDoTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
