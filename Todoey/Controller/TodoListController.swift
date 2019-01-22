//
//  ViewController.swift
//  Todoey
//
//  Created by EricLian on 2019/1/22.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class TodoListController: UITableViewController {

    var itemArray = [item]()
    let userdefault = UserDefaults.standard
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        let newitem = item()
        newitem.title = "hello"
        itemArray.append(newitem)
        
        if let items = userdefault.array(forKey: "Todolistarray") as? [item]
        {
            itemArray = items
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        //cell.textLabel?.text = itemArray[indexPath.row].title
        cell.textLabel?.text = item.title
        
//        if itemArray[indexPath.row].done == false
//        {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }
//        else
//        {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
//                if item.done == false
//                {
//                    tableView.cellForRow(at: indexPath)?.accessoryType = .none
//                }
//                else
//                {
//                    tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//                }
        cell.accessoryType = item.done ? .checkmark : .none

        tableView.reloadData()

        return cell
    }
    
    // Table delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
//        if itemArray[indexPath.row].done == false
//        {
//            itemArray[indexPath.row].done = true
//        }
//        else
//        {
//            itemArray[indexPath.row].done = false
//        }
//
        itemArray[indexPath.row].done  = !itemArray[indexPath.row].done
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK - Add new item
    @IBAction func AddButtonPressed(_ sender: Any)
    {
        //step3
        var temp_textfield = UITextField()
        
        //step1
        let alert = UIAlertController(title: "Add new todoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
          //  print("alert ok")
           // print (temp_textfield.text)
            let newitem = item()
            newitem.title = temp_textfield.text!
            
            self.itemArray.append(newitem)
            
            self.tableView.reloadData()
            
            self.userdefault.setValue(self.itemArray, forKey: "Todolistarray")
        }
        
        //step2
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Creat a new item"
            temp_textfield = alertTextfield
        }
        
        //step1
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
     
    }
    
    
}

