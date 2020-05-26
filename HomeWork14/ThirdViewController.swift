//
//  ThirdViewController.swift
//  HomeWork14
//
//  Created by Сергей Кузнецов on 20.05.2020.
//  Copyright © 2020 Сергей Кузнецов. All rights reserved.
//

import UIKit
import RealmSwift

class ThirdViewController: UIViewController {
    
    private let realm = try! Realm()
 
    @IBOutlet weak var toDoTableView: UITableView!
    @IBAction func addOneTask(_ sender: Any) {
        self.alert(title: "Добавить задачу", message: "Введите название задачи", style: .alert)
    }
    func alert( title: String, message: String, style: UIAlertController.Style){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        let action = UIAlertAction(title: "Добавить", style: .default) { (action) in
            let text = alertController.textFields?.first?.text
           let task = Tasks()
            task.name = text!
            try! self.realm.write {
                self.realm.add(task)
            }
            self.toDoTableView.reloadData()
        }
        
        let cancelButton = UIAlertAction(title: "Отменить", style: .cancel)
        
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(action)
        alertController.addAction(cancelButton)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ThirdViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.realm.objects(Tasks.self).count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell") as! TableViewCell
        let model = self.realm.objects(Tasks.self)[indexPath.row]
        cell.nameTask.text = model.name
        if model.isDone == true {
            cell.accessoryType = .checkmark }
        else { cell.accessoryType = .none }
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = self.realm.objects(Tasks.self)[indexPath.row]
            try! self.realm.write{
                self.realm.delete(task)
            }
            tableView.deleteRows(at: [indexPath], with: .fade) }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        toDoTableView.deselectRow(at: indexPath, animated: true)
        let task = self.realm.objects(Tasks.self)[indexPath.row]
        try! self.realm.write {
            task.isDone = !(task.isDone)
            self.realm.add(task)
        }
        toDoTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
