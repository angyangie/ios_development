//  Created by Angela Ramirez on 5/3/18.
//  Copyright © 2018 Angela Ramirez. All rights reserved.
//

import UIKit
import RealmSwift

class ListTableViewController: UITableViewController, ToDoComposerDelegate, ToDoTableCellDelegate {
    
    // initializing an empty array of type to do
    var toDoList: Results<ToDo>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try? Realm()
        toDoList = realm?.objects(ToDo.self) // results
        
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
        return toDoList?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.identifier, for: indexPath)
        
        if let cell = cell as? ToDoTableViewCell {
            cell.data = toDoList?[indexPath.row]
            cell.delegate = self // WOW
        } // different kinds of cells, much more sustainable and understandable
        
        return cell
    }

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
////       let checkBox = CheckBox()
////       checkBox.buttonClicked(sender: self)
//
//        let tdv = ToDoComposerViewController()
//        tdv.data = toDoList[indexPath.row]
//        navigationController?.pushViewController(tdv, animated: true)
//    }
    
    func showComposer(toDo: ToDo) {
        let tdv = ToDoComposerViewController()
        tdv.data = toDo
        navigationController?.pushViewController(tdv, animated: true)
    }
    
    // HW: BUTTON, button react to changes. ButtonView. UILable....both in the content view inside the cell.
    
    
    func onNewToDo(todo: ToDo) {
        tableView.reloadData() // this is so things actually appear on the page
        // HW MAKE SEPARATE CLASS THAT'S A SINGLETON, THAT ONLY CARES ABOUT REALM. DATASTORE.
    }
    
    @objc func addToDo() {
        let td = ToDoComposerViewController()
        td.delegate = self // we are declaring THIS to be the delegate
        let nc = UINavigationController(rootViewController: td)
        present(nc, animated: true, completion: nil)
    }
}

protocol ToDoTableCellDelegate: class { // be able to associate with class object
    func showComposer(toDo: ToDo)
}

class ToDoTableViewCell: UITableViewCell {
    weak var delegate: ToDoTableCellDelegate?
    
    var isChecked: Bool?
    static let identifier = "To do cell"
    var data: ToDo? {
        didSet {
            textLabel?.text = data?.title // sets the text displayed to what is stored in data!
            isChecked = data?.isChecked
        }
    } // everytime data is set, everytime it changes, set the data coming back to textLabel!
    
    let button = UIButton() // subview of UIview, backgroundView, imageView

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) { // UITableViewCellStyle gives you textLabel, detailTextLabel
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(white: 1, alpha: 0.5)
        textLabel?.textColor = .white
        textLabel?.font = UIFont.boldSystemFont(ofSize: 30)

        contentView.addSubview(button)
        
        button.addTarget(self, action: #selector(goToComposer), for: .touchUpInside)
        
        // is imageVIew here???
//        updateImageObject()
    }
    
    @objc func goToComposer() {
        // guards are great at the beginning of the function, avoid in middle. They unwrap your variables.
        guard let toDo = data else { return } // don't get into indent hell
        
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.showComposer(toDo: toDo)

        } // things in a tableView are done on a background thread,
        
        
//        if let toDo = data {
//            delegate?.showComposer(toDo: toDo)
//        }
        
    }
    
    override func layoutSubviews() { // called when the view first comes in, when it comes out, when scrolling...when things need to be resized, etc. Don't want to put a lot of logic here
        super.layoutSubviews()
        button.frame = contentView.bounds
        
    }
    
//    @objc func updateImageObject() {
//        if isChecked == true {
//            let checkedImage = UIImage(named: "checked")
//            imageView?.image = checkedImage
//        } else {
//            let unCheckedImage = UIImage(named: "unchecked")
//            imageView?.image = unCheckedImage
//        }
//    }
    
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
