//
//  RealmModel.swift
//  HomeWork14
//
//  Created by Сергей Кузнецов on 24.05.2020.
//  Copyright © 2020 Сергей Кузнецов. All rights reserved.
//

import Foundation
import RealmSwift

class Tasks: Object {
    @objc dynamic var name = ""
    @objc dynamic var isDone: Bool = false
}

class Actions{
    static let action = Actions()
    let realm = try! Realm()
    let tasks = Tasks()
    lazy var taskObject: Results<Tasks> = { self.realm.objects(Tasks.self)}()
    
    func save(names: String) {
        tasks.name = names
        try! realm.write {
            realm.add(tasks)
        }
    }
    func delete(index: Int) {
        try! realm.write{
            realm.delete(taskObject[index])
        }
    }
    func done(index: Int){
        let taskObject = realm.objects(Tasks.self)[index]
        try! realm.write{
            taskObject.isDone = !(taskObject.isDone)
            realm.add(taskObject)
        }
    }
    func change(names: String, index: Int){
        let taskObject = realm.objects(Tasks.self)[index]
        try! realm.write{
            taskObject.name = names
        }
    }
}
