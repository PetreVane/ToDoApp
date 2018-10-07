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
    let defaults = UserDefaults()
    
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
        
        // Replacing the listElements with an updated version, retreived from UserDefaults

//        if let updatedListElements = defaults.array(forKey: "myUpdatedList") as? [Item] {
//            listElements = updatedListElements
//        }

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
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }

        return cell
    }
    
    
    // tapping into table properties
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // making the cell flash one time when selected
        tableView.deselectRow(at: indexPath, animated: true)
        
     // Toggling the .done property of the cell Object
        
//        if listElements[indexPath.row].done == false {
//            listElements[indexPath.row].done = true
//        } else {
//            listElements[indexPath.row].done = false
//        }
//
        // refactoring code
         listElements[indexPath.row].done = !listElements[indexPath.row].done
        
        
        tableView.reloadData()
        // Adding a checkmark for each cell
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }

    }
    
    
    @IBAction func barButtonPressed(_ sender: UIBarButtonItem) {
        
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
            
            // Reloading table view data
            self.tableView.reloadData()
        }

        myAlert.addAction(myAction)
        
        // Adding a textfield within the alert
       
        myAlert.addTextField { (myAlertTextField) in
            myAlertTextField.placeholder = "Type in new item"
       
            //Step 2: capturing what the user types and storing the value into the 'global' variable, so it will be available outside the scope of this closure
            
            myTextField.text = myAlertTextField.text!
        }
        // Presenting your alert to the ViewController
        present(myAlert, animated: true, completion: nil)
        
    }
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
