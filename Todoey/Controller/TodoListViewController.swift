//
//  ViewController.swift
//  Todoey
//
//  Created by Vimosanan Ahiladas on 11/29/19.
//  Copyright © 2019 Vimosanan Ahiladas. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    var itemsArray = [Item]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    //MARK: - Tableview Datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemsArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK: - Tableview Delagate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemsArray[indexPath.row].done = !itemsArray[indexPath.row].done
        
        self.saveData()
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    //MARK: - Add New Item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()

        let alert = UIAlertController(title: "Add New Todoey Item", message: "HI", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            
            
            let item = Item(context: self.context)
            
            item.title = textField.text!
            item.done = false
            self.itemsArray.append(item)

            self.saveData()
        }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create an item"
            textField = alertTextField
        }

        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Save Custom data to Preferences
    func saveData(){
        do {
            try context.save()

        } catch {
            print("Error saving data \(error)")
        }
        self.tableView.reloadData()
    }

    //MARK: - Load Custom data from preferences
    func loadData() {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            itemsArray = try context.fetch(request)
        } catch {
            print("Error fetching data \(error)")
        }
    }
}

