//
//  ToDoViewController.swift
//  ToDoey
//
//  Created by Petre Vane on 29/09/2018.
//  Copyright © 2018 Petre Vane. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {

    // MARK: - Outlets
    
    var listElements = [Item]()
    
    // Creating a UserDefaults() object
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("myCustomItems.plist")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSavedData()
        
<<<<<<< HEAD
        // Replacing the listElements with an updated version, retreived from UserDefaults

//        if let updatedListElements = defaults.array(forKey: "myUpdatedList") as? [Item] {
//            listElements = updatedListElements
//        }

=======
>>>>>>> develop
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
    // refactoring code
        
        listElements[indexPath.row].done = !listElements[indexPath.row].done
        saveUpdatedData()
        
    }
    
    
    @IBAction func barButtonPressed(_ sender: UIBarButtonItem) {
        
<<<<<<< HEAD
        // Step 1: declaring a placeholder within the scope of the method
        let myTextField = UITextField()
        
        
        let myAlert = UIAlertController(title: "Add new item on your list", message: "", preferredStyle: .alert)
        
        let myAction = UIAlertAction(title: "Add item", style: .default) { (action) in

            
        // Step 3: using the value of the 'global' variable within the scope of this closure
            //print("your captured text is: \(myTextField.text!)")
            
            var newItem4 = Item()
            newItem4.title = myTextField.text!
            
            self.listElements.append(newItem4)
            
            // Saving the current state to User Defaults. Add 'self' because you're inside a closure
            //self.defaults.set(self.listElements, forKey: "myUpdatedList")
=======
        var localTextField = UITextField()
        
        let myAlert = UIAlertController(title: "Add new items on your list", message: "", preferredStyle: .alert)
       
        let myAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = localTextField.text!
            self.listElements.append(newItem)
>>>>>>> develop
            
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
        
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(listElements)
            try data.write(to: dataFilePath!)
        } catch {
            print("Your error is: \(error)")
        }
        
        tableView.reloadData()
    }
    
    
        
    func loadSavedData(){
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            
            let decoder = PropertyListDecoder()
            do {
                listElements = try decoder.decode([Item].self, from: data)
            } catch {
                print("Your decoder error is: \(error)")
            }
        }
        
    }
        
        
 
        
        
      
        
  
        
    }
    
    


