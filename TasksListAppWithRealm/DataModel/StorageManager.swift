//
//  StorageManager.swift
//  TasksListAppWithRealm
//
//  Created by Andrii Nepodymka on 10/17/21.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    static func saveObject(_ task: TasksModel) {
        try! realm.write {
            realm.add(task)
        }
    }
    
    
    static func deleteTask(_ task: TasksModel) {
        try! realm.write {
            realm.delete(task)
        }
    }
}
