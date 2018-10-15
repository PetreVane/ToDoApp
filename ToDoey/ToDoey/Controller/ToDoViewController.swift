//
//  ToDoViewController.swift
//  ToDoey
//
//  Created by Petre Vane on 29/09/2018.
//  Copyright © 2018 Petre Vane. All rights reserved.
//

import UIKit
import CoreData

class ToDoViewController: UITableViewController {

    // MARK: - Variables & Constants
    
    var listElements = [Item]()
    
    // Creating a UserDefaults() object
    let dataBaseFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let dataBaseFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //print("Your database filepath is: \(dataBaseFilePath)")
        
        loadSavedData()
        
        }

    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listElements.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)

        // Configure the cell...
        let item = listElements[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        // value = condition ? valueIFTrue : valueIFFalse
       
       cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    
    // tapping into table properties
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // making the cell flash one time when selected
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Toggling the .done property of the cell Object
        listElements[indexPath.row].done = !listElements[indexPath.row].done
        
        // Testing removing elements from Context first
        // context.delete(listElements[indexPath.row])
        
        // Then removing it from the array
        // listElements.remove(at: indexPath.row)
        
        saveUpdatedData()
        
    }
    
    
    @IBAction func barButtonPressed(_ sender: UIBarButtonItem) {
        
        var localTextField = UITextField()
        
        let myAlert = UIAlertController(title: "Add new items on your list", message: "", preferredStyle: .alert)
       
        let myAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item(context: self.context)
            
            newItem.title = localTextField.text!
            newItem.done = false
            
            self.listElements.append(newItem)
            
            self.saveUpdatedData()
        }
        
        myAlert.addAction(myAction)
        
        myAlert.addTextField { (myAlertTextField) in
            
            myAlertTextField.placeholder = "Type your items here"
            localTextField = myAlertTextField
        }
        
        present(myAlert, animated: true, completion: nil)
        
    }
        

    
    func saveUpdatedData() {
        
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
        
        tableView.reloadData()
    }
    
    
        
    func loadSavedData(with request: NSFetchRequest<Item> = Item.fetchRequest()){
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
           listElements = try context.fetch(request)
        } catch {
            print("Your fetching error is: \(error)")
        }
        tableView.reloadData()
        }

    }


extension ToDoViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS [cd] %@", searchBar.text!)
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        
        request.predicate = predicate
        request.sortDescriptors = [sortDescriptor]
        
        do {
            listElements = try context.fetch(request)
        } catch {
            print("Your fetching error is: \(error)")
        }
        
        
    }
    
    
}
  
        

    
    


