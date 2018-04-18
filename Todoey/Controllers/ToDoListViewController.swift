//
//  ViewController.swift
//  Todoey
//
//  Created by Jonathan Persaud on 4/16/18.
//  Copyright © 2018 Jonathan Persaud. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
var strangerItems = [Items]()
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        let item = Items()
        item.toDo = "Find Will"
        strangerItems.append(item)
        
        // Do any additional setup after loading the view, typically from a nib.
        //Fetches User Default and Core Data
        if let items = defaults.object(forKey: "strangerItemsArray") as? [Items]{
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
        cell.textLabel?.text = strangerItems[indexPath.row].toDo
        
        if strangerItems[indexPath.row].done == true {
            cell.accessoryType = .checkmark
        }
        else{
            cell.accessoryType = .none
        }
        return cell
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if strangerItems[indexPath.row].done == false{
            strangerItems[indexPath.row].done = true
        }
        else{
            strangerItems[indexPath.row].done = false
        }
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new ToDo Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        
        let alertController = UIAlertController(title: "Add New Task", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add new Task", style: .default){(action) in
            print(textfield.text!)
            let newItem = Items()
            newItem.toDo = textfield.text!
            self.strangerItems.append(newItem)
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

