//
//  ListTableViewController.swift
//  ToDos
//
//  Created by Angela Ramirez on 5/3/18.
//  Copyright © 2018 Angela Ramirez. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController, ToDoComposerDelegate {

    var toDoList = [ToDo]() // initializing an empty array of type to do
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My List"
        tableView.backgroundColor = .cyan
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToDo))
        
        // register table view cell
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.identifier)
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // number of items expected in list
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }

    // returns cell to be displayed
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.identifier, for: indexPath)
        
        if let cell = cell as? ToDoTableViewCell {
            cell.data = toDoList[indexPath.row]
        } // different kinds of cells, much more sustainable and understandable

        return cell
    }
    
    // DELEGATE - defines functions that respond to events in the tableview. "when user taps item, or when they swipe."
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tdv = ToDoComposerViewController()
        tdv.data = toDoList[indexPath.row]
        navigationController?.pushViewController(tdv, animated: true)

    }
    
    func onNewToDo(todo: ToDo) {
        toDoList.append(todo)
        tableView.reloadData()
        // this is so things actually appear on the page
    }
    
    @objc func addToDo() {
        print("hello!")
        let td = ToDoComposerViewController()
        td.delegate = self
        let nc = UINavigationController(rootViewController: td)
        present(nc, animated: true, completion: nil)
    }
}

class ToDoTableViewCell: UITableViewCell {
    
    static let identifier = "To do cell"
    var data: ToDo? {
        didSet {
            textLabel?.text = data?.title
        }
    } // everytime data is set
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .red
        textLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        // any view you put into the cell, you should put in here!
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
