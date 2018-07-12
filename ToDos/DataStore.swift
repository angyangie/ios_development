//
//  DataStore.swift
//  ToDos
//
//  Created by Angela Ramirez on 7/12/18.
//  Copyright © 2018 Angela Ramirez. All rights reserved.
//

import Foundation
import RealmSwift

class DataStore { // singleton, accessible from anywhere in your app!! in general, you avoid this though.
    static let shared = DataStore() //classvariable, static means it's only evaluated once
    private var realm: Realm? //make private, no one else knows (file private, only in file)
    
    var toDoList: [ToDo] {
        guard let realm = realm else { return [] }
        let list = realm.objects(ToDo.self) // this is a results (list)...need to turn it into an array
        return Array(list)
    }
    
    init() {
        do {
            realm = try Realm() //with try should live within do block, so don't need optional or exclamation
        } catch let error {
            print(error)
        } // we're dealing with the erorr Realm might throw!
    }
    
    func add(toDo: ToDo) {
        guard let realm = realm else { return }
        try? realm.write {
            realm.add(toDo)
        }
    }
    
    func update(toDo: ToDo, title: String, description: String) {
        guard let realm = realm else { return }
        try? realm.write {
            toDo.title = title
            toDo.desc = description
        }
    } // update struct could be an option
}

