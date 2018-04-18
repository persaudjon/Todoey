//
//  ViewController.swift
//  Todoey
//
//  Created by Jonathan Persaud on 4/16/18.
//  Copyright © 2018 Jonathan Persaud. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
var strangerItems = ["Take out Garbage","Kill Demogorgon","Buy Eggos"]
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Fetches User Default and Core Data
        if let items = defaults.object(forKey: "strangerItemsArray") as? [String]{
            print("Found Core Data For ToDo's")
            strangerItems = items
        }
        
    }
    //Creates amount of cells in table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strangerItems.count
    }
    //Fills cells with array items
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"ToDoItemCell" , for: indexPath)
        cell.textLabel?.text = strangerItems[indexPath.row]
        return cell
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        if(tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark){
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    
    //MARK - Add new ToDo Item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        
        let alertController = UIAlertController(title: "Add New Task", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add new Task", style: .default){(action) in
            print(textfield.text!)
            self.strangerItems.append(textfield.text!)
            self.defaults.setValue(self.strangerItems, forKey: "strangerItemsArray")
           self.tableView.reloadData()
        }
        
            alertController.addTextField(configurationHandler: { (newTaskTextField) in
                newTaskTextField.placeholder? = "Enter New Task"
                textfield = newTaskTextField
            })
        
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

