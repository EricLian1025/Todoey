//
//  ViewController.swift
//  Todoey
//
//  Created by EricLian on 2019/1/22.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class TodoListController: UITableViewController
{
  
    var todoItems : Results<Item>?
    let realm = try! Realm()
//    let userdefault = UserDefaults.standard
//
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items plist")

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
    var selectedcategory : Category?
    {
        didSet // this will be execute when value is filled.
        {
           loaditems()
        }
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row]
        {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        }
        else
        {
             cell.textLabel?.text = "no ittems added."
        }

        return cell
    }
    
    //MARK: Table delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {

        if let item = todoItems?[indexPath.row]
        {
           do
            {
                try realm.write
                {
                    item.done = !item.done
                }
                
              }
                catch
                {
                    print("mark and unmark wrongly")
                }
            
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: MARK - Add new item
    @IBAction func AddButtonPressed(_ sender: Any)
    {
        //step3
        var temp_textfield = UITextField()
        
        //step1
        let alert = UIAlertController(title: "Add new todoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "additem", style: .default) { (action) in
//
            if let category = self.selectedcategory
            {
                do
                {
                    try self.realm.write
                    {
                        let newitem = Item()
                        newitem.title = temp_textfield.text!
                        newitem.date = Date()
                        category.ct_items.append(newitem)
                    }

                }
                catch
                {
                    print("error")
                }
            }
            
            self.tableView.reloadData()
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

    
    //MARK: load encode function
    func loaditems()
    {
        todoItems = selectedcategory?.ct_items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
//
//
}

//MARK: - searchbar methods
extension TodoListController : UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
         todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
        
        // todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "date", ascending: true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchBar.text?.count == 0
        {
            self.loaditems()
            DispatchQueue.main.async
                {
                  searchBar.resignFirstResponder() // return to default.
            }

        }
      }
    
}


