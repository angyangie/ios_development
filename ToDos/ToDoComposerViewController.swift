//
//  ViewController.swift
//  ToDos
//
//  Created by Angela Ramirez on 5/3/18.
//  Copyright © 2018 Angela Ramirez. All rights reserved.
//

import UIKit

class ToDoComposerViewController: UIViewController {
    var isChecked: Bool?
    var data: ToDo? {
        didSet {
            titleInput.text = data?.title
            textArea.text = data?.desc
            isChecked = data?.isChecked
        }
    }
    let titleInput = UITextField()
    let textArea = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Edit to Do"
        
        if isModal() {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAdd)) // if presented modally
            title = "New to Do"
        }
        
        // adding save button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAdd))
        
        // styling for titleInput and textArea
        titleInput.placeholder = "add title here"
        titleInput.borderStyle = .roundedRect
        titleInput.textAlignment = .center
        titleInput.frame = CGRect(x: 20, y: view.bounds.height - 300, width: view.bounds.width - 40, height: 40)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Add background image to composer
        let backgroundImage = UIImage(named: "alpha_regal")
        let imageView = UIImageView(image: backgroundImage)
        imageView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
//        imageView.contentMode = .scaleAspectFill
//        imageView.backgroundColor = .red
        
        self.view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)

    }
    
    func isModal() -> Bool {
        return self.presentingViewController?.presentedViewController == self
            || (self.navigationController != nil && self.navigationController?.presentingViewController?.presentedViewController == self.navigationController)
            || self.tabBarController?.presentingViewController is UITabBarController
    }
    
    @objc func saveAdd() {
        if let data = data { // if data exists, set to this variable. inside data guaranteed it exists
            DataStore.shared.update(toDo: data, title: titleInput.text ?? "", description: textArea.text, isChecked: nil)
            navigationController?.popViewController(animated: true)
        } else {
            let data = ToDo()
            data.title = titleInput.text ?? ""
            data.desc = textArea.text
            
            DataStore.shared.add(toDo: data)
            dismiss(animated: true, completion: nil) // dismiss a modal!
        }
    }

    @objc func cancelAdd() {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning() // Dispose of any resources that can be recreated.
//        DataStore.shared
    }
}
