//
//  ViewController.swift
//  ToDos
//
//  Created by Angela Ramirez on 5/3/18.
//  Copyright © 2018 Angela Ramirez. All rights reserved.
//

import UIKit

protocol ToDoComposerDelegate: class {
    func onNewToDo(todo: ToDo)
}
// why func declared in TODO.SWIFT?

class ToDoComposerViewController: UIViewController {
    
    var data: ToDo? {
        didSet {
            titleInput.text = data?.title
            textArea.text = data?.description
            
        }
    }
    
//    let realm = try! Realm()
//    let toDoItems = realm.objects(ToDo.self)
//    print("To do items coming")
//    print(toDoItems)

    // data may exist, if not we want to clear the form
    
    weak var delegate: ToDoComposerDelegate?
    // want to avoid memory leaks!! prevents this. when the counter comes by and counts all retains, if something is weak, it doesn't count it against it. When you create a memory leak, you can cause a crash.
    let titleInput = UITextField()
    let textArea = UITextView()
    //important that they're class variables, because these will need to change!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = .yellow
        title = "Edit to do"
        
        if navigationController == nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAdd)) // if presented modally
            title = "New to Do"
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAdd))
        
        titleInput.placeholder = "add title here"
        titleInput.borderStyle = .roundedRect
        titleInput.textAlignment = .center
        titleInput.frame = CGRect(x: 20, y: 70, width: view.bounds.width - 40, height: 40)
        titleInput.backgroundColor = .white
        view.addSubview(titleInput)
        
        textArea.frame = CGRect(x: 20, y: titleInput.frame.maxY + 20, width: view.bounds.width - 40, height: 80)
        textArea.backgroundColor = .white
        view.addSubview(textArea)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        titleInput.becomeFirstResponder()
        
    }
    
    @objc func saveAdd() {
        // if data exists, we'll set it to this variable. inside data guaranteed it exists
        if let data = data {
            data.title = titleInput.text ?? ""
            data.description = textArea.text
            navigationController?.popViewController(animated: true)
        } else {
            let new = ToDo(title: titleInput.text ?? "untitled", description: textArea.text)
            delegate?.onNewToDo(todo: new)
            dismiss(animated: true, completion: nil) // dismiss a modal!
        }
    }
    
    @objc func cancelAdd() {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

