//  Created by Angela Ramirez on 5/3/18.
//  Copyright © 2018 Angela Ramirez. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController, ToDoComposerDelegate {

    var toDoList = [ToDo]() // initializing an empty array of type to do
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToDo))
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.identifier)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Add a background view to the table view
        let backgroundImage = UIImage(named: "alpha_backyard")
        let imageView = UIImageView(image: backgroundImage)
        imageView.contentMode = .scaleAspectFill
    
        // add imageView to background
        self.tableView.backgroundView = imageView
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        // reload data
        tableView.reloadData()

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.identifier, for: indexPath)
        
        if let cell = cell as? ToDoTableViewCell {
            cell.data = toDoList[indexPath.row]
        } // different kinds of cells, much more sustainable and understandable
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

//       let checkBox = CheckBox()
//       checkBox.buttonClicked(sender: self)

        let tdv = ToDoComposerViewController()
        tdv.data = toDoList[indexPath.row]
        navigationController?.pushViewController(tdv, animated: true)
    }
    
    func onNewToDo(todo: ToDo) {
        toDoList.append(todo) // adding ToDo to the ToDolist
        tableView.reloadData() // this is so things actually appear on the page
    }
    
    @objc func addToDo() {
        let td = ToDoComposerViewController()
        td.delegate = self // we are declaring THIS to be the delegate
        let nc = UINavigationController(rootViewController: td)
        present(nc, animated: true, completion: nil)
    }
}

class ToDoTableViewCell: UITableViewCell {
    var isChecked: Bool?
    static let identifier = "To do cell"
    var data: ToDo? {
        didSet {
            textLabel?.text = data?.title // sets the text displayed to what is stored in data!
            isChecked = data?.isChecked
        }
    } // everytime data is set, everytime it changes, set the data coming back to textLabel!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) { // UITableViewCellStyle gives you textLabel, detailTextLabel
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(white: 1, alpha: 0.5)
        textLabel?.textColor = .white
        textLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(wasTapped))
        imageView?.addGestureRecognizer(tap)
        // is imageVIew here???
        updateImageObject()
    }
    
    @objc func wasTapped() {
        isChecked = !isChecked!
        updateImageObject()
    }
    
    @objc func updateImageObject() {
        if isChecked == true {
            let checkedImage = UIImage(named: "checked")
            imageView?.image = checkedImage
        } else {
            let unCheckedImage = UIImage(named: "unchecked")
            imageView?.image = unCheckedImage
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



//    class CheckBox: UIButton {
//        let checkedImage = UIImage(named: "checked")
//        let unCheckedImage = UIImage(named: "unchecked")
//
//        // Bool property
//        var isChecked: Bool = false {
//            didSet{
//                if isChecked == true {
//                    self.setImage(checkedImage, for: UIControlState.normal)
//                } else {
//                    self.setImage(unCheckedImage, for: UIControlState.normal)
//                }
//            }
//        }
//
//        override func awakeFromNib() {
//            self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControlEvents.touchUpInside)
//            self.isChecked = false
//        }
//
//        @objc func buttonClicked(sender: ListTableViewController) {
//            if sender == self {
//                isChecked = !isChecked
//            }
//        }
//    }
