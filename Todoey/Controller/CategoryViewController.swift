//
//  TableViewController.swift
//  Todoey
//
//  Created by EricLian on 2019/1/22.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController
{

    var categoryarray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        loaditem()

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gotocategorycell", for: indexPath)
        
        let item = categoryarray[indexPath.row]
        
        cell.textLabel?.text = item.name
    
        if(cell.accessoryType == .checkmark)
        {
         cell.accessoryType = .checkmark
        }
        else
        {
            cell.accessoryType = .none
        }
        
        return cell

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryarray.count
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
            destinationVC.selectedcategory = categoryarray[indexpath_.row]
        }
    }
    
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
    
    func loaditem(with request: NSFetchRequest<Category> = Category.fetchRequest())
    {
        do
        {
            categoryarray =  try context.fetch(request)
        }
        catch
        {
            print("error occurred \(error)")
        }
        tableView.reloadData()
    }
    
    
    @IBAction func addbuttonpressed(_ sender: Any)
    {
        var temp_textfield = UITextField()
        
        let alert = UIAlertController(title: "Add a new item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default)
        {
            (action) in
            
            let newitem = Category(context: self.context)
            newitem.name = temp_textfield.text!
            self.categoryarray.append(newitem)
            //  self.userdefault.setValue(self.itemArray, forKey: "Todolistarray")
            self.saveitem()
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
