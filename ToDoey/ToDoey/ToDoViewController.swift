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
    
    var listElements = ["Grab a beer", "Grab a towel", "Wash your beard"]
    
    //@IBOutlet var tableView: UITableView! --> this is not needed when having an UITableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        cell.textLabel?.text = listElements[indexPath.row]

        return cell
    }
    
    
    // tapping into table properties
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // making the cell flash one time when selected
        tableView.deselectRow(at: indexPath, animated: true)
        
        // printing the content of the cells
        
        print("Your cell content is: \(listElements[indexPath.row])")
        
        // Adding a checkmark for each cell
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
    }
    
    
    @IBAction func barButtonPressed(_ sender: UIBarButtonItem) {
        
        // Step 1: declaring a placeholder within the scope of the method
        var myTextField = UITextField()
        
        let myAlert = UIAlertController(title: "Add new item on your list", message: "", preferredStyle: .alert)
        
        let myAction = UIAlertAction(title: "Add item", style: .default) { (action) in
            
            // What will happen when the + button is pressed
            //print ("Success")
            
        // Step 3: using the value of the 'global' variable within the scope of this closure
            //print("your captured text is: \(myTextField.text!)")
            
            self.listElements.append(myTextField.text!)
            self.tableView.reloadData()
        }

        myAlert.addAction(myAction)
        
        // Adding a textfield within the alert
       
        myAlert.addTextField { (myAlertTextField) in
            myAlertTextField.placeholder = "Type in new item"
       
            //Step 2: capturing what the user types and storing the value into the 'global' variable, so it will be available outside the scope of this closure
            
            myTextField = myAlertTextField
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
