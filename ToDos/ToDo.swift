//
//  ToDo.swift
//  ToDos
//
//  Created by Angela Ramirez on 5/10/18.
//  Copyright © 2018 Angela Ramirez. All rights reserved.
//

import Foundation
//import Realm

// class because we need to be able to update!! with structs, no way to update
class ToDo {
    var title: String
    var description: String
    
    init (title: String, description: String) {
        self.title = title
        self.description = description
    }
}


//    let realm = realm
//    let toDoItems = realm.objects(ToDo.self)
//    print("To do items coming")
//    print(toDoItems)
