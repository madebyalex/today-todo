//
//  ViewController.swift
//  Today-Todo
//
//  Created by Alexander on 06.09.2020.
//  Copyright © 2020 Alexander Nuzhnyi. All rights reserved.
//

import UIKit

class TodoListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
//    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath)
        
//        let newItem = Item()
//        newItem.title = "Have fun"
//        items.append(newItem)
//        
//        let newItem2 = Item()
//        newItem2.title = "Learn new things"
//        items.append(newItem2)
//        
//        let newItem3 = Item()
//        newItem3.title = "Take a lesson of Spanish"
//        items.append(newItem3)
//        
//        let newItem4 = Item()
//        newItem4.title = "Prepare a new to-do list"
//        items.append(newItem4)
        
//        if let savedItems = defaults.array(forKey: "TodoListArray") as? [Item] {
//            items = savedItems
//        }
        
        loadItems()
    }
    
    
    //MARK: - TableView Datasource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "datacell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let currentItem = items[indexPath.row]
        cell.textLabel?.text = currentItem.title

        cell.accessoryType = currentItem.done ? .checkmark : .none
        
        return cell
    }

    
    //MARK: - TableView Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        items[indexPath.row].done = !items[indexPath.row].done
        self.saveItems()
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text!
            
            // Checking for an empty input
            if textField.text != "" {
                self.items.append(newItem)
            } else {
                return
            }
            
//            self.defaults.set(self.items, forKey: "TodoListArray")
            
            self.saveItems()
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "E.g. Save the world"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    //MARK: - Model Manipulation Methods
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data =  try encoder.encode(items)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding an item array, \(error)")
        }
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                items = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item array, \(error)")
            }
        }
    }
    
}

