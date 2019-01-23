//
//  ViewController.swift
//  Todoey
//
//  Created by EricLian on 2019/1/22.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import CoreData

class TodoListController: UITableViewController
{
  
    var itemArray = [Item]()
   
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
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]

        cell.textLabel?.text = item.title
    
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK: Table delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        itemArray[indexPath.row].done  = !itemArray[indexPath.row].done
        saveitem()
        tableView.reloadData() // to call cellforeowat delegate then
        //1. ture or false
        //2. reload all data - mark or unmark
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: MARK - Add new item
    @IBAction func AddButtonPressed(_ sender: Any)
    {
        //step3
        var temp_textfield = UITextField()
        
        //step1
        let alert = UIAlertController(title: "Add new todoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default)
        { (action) in
          //  print("alert ok")

            //core data
            let newitem = Item(context: self.context)
            newitem.title = temp_textfield.text!
            newitem.parentCategory = self.selectedcategory
            self.itemArray.append(newitem)
   
          //  self.userdefault.setValue(self.itemArray, forKey: "Todolistarray")
          self.saveitem()
            
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
    
    //MARK: func saveitem method
    func saveitem()
    {
        do
        {
          try context.save()
        }
        catch
        {
           print("Error occurred. Reason is-\(error)")
        }
        
    }
    
    //MARK: load encode function
    func loaditems(with request: NSFetchRequest<Item> = Item.fetchRequest() , predicate: NSPredicate? = nil)
    {
        let categorypredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedcategory!.name!)
 
        if let addtionalpredicate = predicate
        {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categorypredicate,addtionalpredicate]) // 1=parent match + 2=search item
        }
        else
        {
            request.predicate = categorypredicate // only match
        }
        
       do
        {
           itemArray = try context.fetch(request)
        }
        catch
        {
           print("fetch error occurred. Reason is-\(error)")
        }
        
        tableView.reloadData()
    }
    
  
}

//MARK: - searchbar methods
extension TodoListController : UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
 
       loaditems(with: request,predicate: predicate)

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchBar.text?.count == 0
        {
            loaditems()
            DispatchQueue.main.async
                {
                  searchBar.resignFirstResponder() // return to default.
            }
          
        }
    }

}


