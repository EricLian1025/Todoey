//
//  ViewController.swift
//  Todoey
//
//  Created by EricLian on 2019/1/22.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class TodoListController: UITableViewController {

    var itemArray = ["111","222","333"]
    let userdefault = UserDefaults.standard
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
   
        if let items = userdefault.array(forKey: "Todolistarray") as? [String]
        {
            itemArray = items
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    // Table delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
       // print(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        //s2.add accessery as mark in object(cell) invesgator
        if    tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }

        
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
       self.itemArray.append(temp_textfield.text!)
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

