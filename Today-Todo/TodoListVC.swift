//
//  ViewController.swift
//  Today-Todo
//
//  Created by Alexander on 06.09.2020.
//  Copyright © 2020 Alexander Nuzhnyi. All rights reserved.
//

import UIKit

class TodoListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let items = ["Item #1", "Second item", "Another one", "Number 4", "The last one"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - TableView Datasource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "datacell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }

    
    //MARK: - TableView Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
}

