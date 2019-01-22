//
//  ViewController.swift
//  Todoey
//
//  Created by EricLian on 2019/1/22.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class TodoListController: UITableViewController {

    let itemArray = ["111","222","333"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
   
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
    
    
    
    
}
