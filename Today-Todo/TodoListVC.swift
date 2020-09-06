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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "datacell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }


}

