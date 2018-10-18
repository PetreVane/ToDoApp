//
//  CategoryViewController.swift
//  ToDoey
//
//  Created by Petre Vane on 18/10/2018.
//  Copyright © 2018 Petre Vane. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }

    // MARK: - Setting the context
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categoryList = [Category]()
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)

        // Configure the cell...
        
        cell.textLabel?.text = categoryList[indexPath.row].name

        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // tap animation
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    // MARK: - Alert
    
    @IBAction func barButtonPressed(_ sender: UIBarButtonItem) {
        
        // Grabing textField content
        var textField = UITextField()
        
        // Setting the alert
        
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Save", style: .default) { (action) in
            
            // what happens when the button is pressed
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categoryList.append(newCategory)
            self.saveData()
            
            
        }
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Type your Category name here..."
            textField = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    // MARK: - Data manipulation methods
    
    func saveData() {
        
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadData() {
        
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categoryList = try context.fetch(request)
        } catch {
            print("Error loading from context: \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    
}
