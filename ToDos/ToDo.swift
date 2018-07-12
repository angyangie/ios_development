//
//  ToDo.swift
//  ToDos
//
//  Created by Angela Ramirez on 5/10/18.
//  Copyright © 2018 Angela Ramirez. All rights reserved.
//

import Foundation
import RealmSwift

// class because we need to be able to update!! with structs, no way to update
class ToDo: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var title: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var isChecked: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}

//    let realm = realm
//    let toDoItems = realm.objects(ToDo.self)
//    print("To do items coming")
//    print(toDoItems)
