//
//  ToDo.swift
//  ToDos
//
//  Created by Angela Ramirez on 5/10/18.
//  Copyright © 2018 Angela Ramirez. All rights reserved.
//

import Foundation

// class because we need to be able to update!! with structs, no way to update
class ToDo {
    var title: String
    var description: String
    
    init (title: String, description: String) {
        self.title = title
        self.description = description
    }
}
