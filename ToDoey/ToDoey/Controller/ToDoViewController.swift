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
    // let defaults = UserDefaults()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("myCustomItems.plist")
    
    //@IBOutlet var tableView: UITableView! --> this is not needed when having an UITableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let newItem = Item()
        newItem.title = "Wash your face"
        listElements.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "MAke your bed"
        listElements.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Have breakfast"
        listElements.append(newItem3)
        

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
        // question ? answer1 : answer2.
        
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
        
        tableView.reloadData()
    }
    
    
    @IBAction func barButtonPressed(_ sender: UIBarButtonItem) {
        
        // Step 1: declaring a placeholder within the scope of the method
        var globalTextField = UITextField()
        let myAlert = UIAlertController(title: "Add new item on your list", message: "", preferredStyle: .alert)
        let myAction = UIAlertAction(title: "Add item", style: .default) { (action) in
            
        // Step 3: using the value of the 'global' variable within the scope of this closure
            var newItemTest = Item()
            newItemTest.title = globalTextField.text!
        
            // Saving the current state to User Defaults.
            let encoder = PropertyListEncoder()
            do {
                let data = try encoder.encode(self.listElements)
                try data.write(to: self.dataFilePath!)
            } catch {
                print("Your error is: \(error)")
            }
            self.listElements.append(newItemTest)
        }
        
        myAlert.addAction(myAction)
        
        // Adding a textfield within the alert
        myAlert.addTextField { (myAlertTextField) in
            myAlertTextField.placeholder = "Bring it to me"
            print (myAlertTextField.text)
        }
        
        //print("You entered: \(globalTextField.text)")
        
        //Step 2: capturing what the user types and storing the value into the 'global' variable, so it will be available outside the scope of this closure
            
            //globalTextField.text = myAlertTextField.text!
            //print ("Your entered text is: \(myAlertTextField.text!)")

        
        // Presenting your alert to the ViewController
        present(myAlert, animated: true, completion: nil)
        
        // Reloading table view data
       tableView.reloadData()
        
    }
    
    

}
