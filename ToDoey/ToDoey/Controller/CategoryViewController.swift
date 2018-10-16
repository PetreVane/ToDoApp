//
//  CategoryViewController.swift
//  ToDoey
//
//  Created by Petre Vane on 16/10/2018.
//  Copyright © 2018 Petre Vane. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
   
    // declared array of Category objects
    var categoryList = [Category]()
    
    // MARK - Setting the context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadContext()

      
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        // what the content of the cell should be
        let selectedCategory = categoryList[indexPath.row]
        cell.textLabel!.text = selectedCategory.name
        
        
        

        // Configure the cell..
    
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // a little bit of animation when touching the cell
        tableView.deselectRow(at: indexPath, animated: true)
        
        //  checkmark  test
        // tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let TrashAction = UIContextualAction.init(style: .normal, title: "Delete") { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            success(true)
        }
        TrashAction.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [TrashAction])
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        // Add UIAlert method
        
        var myText = UITextField()
        
        let myAlert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        let myAction = UIAlertAction(title: "Save Category", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = myText.text!
            self.categoryList.append(newCategory)
            
            self.tableView.reloadData()
            self.saveContext()
        
            }
        
        

        myAlert.addAction(myAction)
        
        myAlert.addTextField { (myAlertTextField) in
            myAlertTextField.placeholder = "Type something here..."
            
            myText = myAlertTextField
        }
        
        present(myAlert, animated: true, completion: nil)
        
     }
    
    
    
    func saveContext() {
        
        do {
            try context.save()
            
        } catch {
            
            print("Your context saving error: \(error)")
            
            }
        }
        
    func loadContext() {
        
        let myRequest: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categoryList = try context.fetch(myRequest)
            
        } catch {
            print("Your fetching error is: \(error)")
        }
        tableView.reloadData()
    }
    
    
    
    
   
    
}


