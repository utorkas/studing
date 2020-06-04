//
//  ToDoList.swift
//  HomeWork14
//
//  Created by Сергей Кузнецов on 20.05.2020.
//  Copyright © 2020 Сергей Кузнецов. All rights reserved.
//

import Foundation
import UIKit
import CoreData

var task = [NSManagedObject]()

func saveData(name: String, isDone: Bool = false) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "ToDoTask", in: managedContext)!
    let person = NSManagedObject(entity: entity, insertInto: managedContext)
    
    person.setValue(name, forKey: "name")
    person.setValue(isDone, forKey: "isDone")
    
    do { try managedContext.save() }
    catch let error as NSError {
        print("Could not save \(error), \(error.userInfo)")}
     task.append(person)
}

func retrieveData() {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoTask")
    do {
        let results = try managedContext.fetch(fetchRequest)
        for result in results as! [NSManagedObject] {
            task.append(result)
            print(task.count)
        }} catch let error as NSError {
        print("Could not save \(error), \(error.userInfo)")}
}

func removeData(at index: Int){
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    
    managedContext.delete(task[index])
    task.remove(at: index)
    
     do{ try managedContext.save() }
     catch let error as NSError {
     print("Could not save \(error), \(error.userInfo)")}
}

func changeStatus(at index: Int){
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let object = task[index]
    if (object.value(forKey: "isDone") as? Bool) == false {
        object.setValue(true, forKey: "isDone") }
    else { object.setValue(false, forKey: "isDone") }
    
     do{ try managedContext.save() }
     catch let error as NSError {
     print("Could not save \(error), \(error.userInfo)")}
}

func changeData(name: String, index: Int){
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
       let managedContext = appDelegate.persistentContainer.viewContext
       let object = task[index]
    if (object.value(forKey: "name") as? String) != nil {
        object.setValue(name, forKey: "name")
    }
        do{ try managedContext.save() }
        catch let error as NSError {
        print("Could not save \(error), \(error.userInfo)")}
}
