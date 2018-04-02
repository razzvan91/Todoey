//
//  ViewController.swift
//  Todoey
//
//  Created by Razvan Armeanu on 02/04/2018.
//  Copyright © 2018 Razvan Armeanu. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Buy Milk"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy Meat"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Buy Bread"
        itemArray.append(newItem3)

    if let items = defaults.array(forKey: "ToDoListArray") as? String {
        itemArray = items
        }
    
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemArray.count
    }
    


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        //SAU
        
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")   ->>> Nu e ok pentru ca se face celula si cand iese de pe ecran se DISTRUGE
        
        let item = self.itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
       itemArray[indexPath.row].done = !itemArray[indexPath.row].done
         tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: Add Button
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen once the user clicks the Add Item button on our UIAlert
            
//            print("Success")         FOR TESTING
//            print(textField.text!)   FOR TESTING
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
        }
        //adding a textfield to the alert
        
        alert.addTextField { (alertTextField) in //se cheama closure asta doar cand creaza textFieldul
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        

        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
}

