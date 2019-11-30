//
//  ViewController.swift
//  Todoey
//
//  Created by Vimosanan Ahiladas on 11/29/19.
//  Copyright © 2019 Vimosanan Ahiladas. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    let itemArray = ["Find Milk", "Buy Eggs", "Destroy mosquitos"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Tableview Datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK: - Tableview Delagate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if ((tableView.cellForRow(at: indexPath)?.accessoryType) == UITableViewCell.AccessoryType.none) {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }


}

