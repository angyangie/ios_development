//
//  ApplicationController.swift
//  ToDos
//
//  Created by Angela Ramirez on 7/12/18.
//  Copyright © 2018 Angela Ramirez. All rights reserved.
//

import UIKit

class ApplicationController {
    let navigationController: UINavigationController
    static let shared = ApplicationController()
    
    init() {
        let listTableViewController = ListTableViewController()
        navigationController = UINavigationController(rootViewController: listTableViewController)
    }
}

// object that you can access from anywhere, so you can swap views in and out, modify data, etc.
// provides the base view, navigationController
