//
//  TableViewController.swift
//  Todoey
//
//  Created by EricLian on 2019/1/22.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class CategoryViewController: UITableViewController
{

    var categoryarray : Results<Category>?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let realm = try! Realm()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        loaditem()

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gotocategorycell", for: indexPath)
        
      
        
        cell.textLabel?.text = categoryarray?[indexPath.row].name ?? "no catagory yet"

        return cell

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryarray?.count ?? 1
               // if .count => nil(since categoryarray is ?), then will auto fill as value 1
    }
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
      performSegue(withIdentifier: "gotoitems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let destinationVC = segue.destination as! TodoListController
        if let indexpath_ = tableView.indexPathForSelectedRow
        {
            destinationVC.selectedcategory = categoryarray?[indexpath_.row]
        }
    }
    
    func saveitem(category : Category)
    {
        do
        {
            try realm.write
            {
                realm.add(category)
            }
        }
        catch
        {
            print("Error occurred. Reason is-\(error)")
        }
        
    }
//    
    func loaditem()
    {
         categoryarray = realm.objects(Category.self)
        tableView.reloadData()
    }
//
    
    @IBAction func addbuttonpressed(_ sender: Any)
    {
        var temp_textfield = UITextField()
        
        let alert = UIAlertController(title: "Add a new item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default)
        {
            (action) in
            
            let newitem = Category()
            newitem.name = temp_textfield.text!
        
            //  self.userdefault.setValue(self.itemArray, forKey: "Todolistarray")
            self.saveitem(category: newitem)
            self.tableView.reloadData()
        }
        alert.addTextField { (alerttextfield) in
            alerttextfield.placeholder = "Add a new item"
            temp_textfield = alerttextfield
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
    }
    

}
