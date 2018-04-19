//
//  PlantTypeTableViewController.swift
//  Sprout
//
//  Created by Kainoa Palama on 4/18/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//

import UIKit
import CoreData

class PlantTypeTableViewController: UITableViewController {
    
    // MARK: - Actions
    
    @IBAction func addButtonTapped(_ sender: Any) {
        var newPlantTypeTextField: UITextField?
        
        let alert = UIAlertController(title: "Add Plant Type", message: "Name of New Plant Type", preferredStyle: .alert)
        
        alert.addTextField {(textfield) in newPlantTypeTextField = textfield}
        
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let save = UIAlertAction(title: "Save", style: .default) { (_) in
            guard let plantTypeName = newPlantTypeTextField?.text else {return}
            
            PlantTypeController.shared.create(plantType: plantTypeName)
            self.tableView.reloadData()
        }
        alert.addAction(cancel)
        alert.addAction(save)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - LifeCycle Function
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        let edit = editAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete, edit])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            let plantTypeToDelete = PlantTypeController.shared.plantTypes[indexPath.row]
            PlantTypeController.shared.delete(plantType: plantTypeToDelete)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            completion(true)
        }
        return action
    }
    
    func editAction(at: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Edit") { (action, view, completion) in
            var plantTypeTextField: UITextField?
            
            let plantTypeToEdit = PlantTypeController.shared.plantTypes[at.row]
        
            let alert = UIAlertController(title: "Edit Plant Type", message: "Edit Name of Plant Type", preferredStyle: .alert)
            
            alert.addTextField { (textfield) in
                textfield.text = plantTypeToEdit.type
                plantTypeTextField = textfield
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            let save = UIAlertAction(title: "Save", style: .default) { (_) in
                guard let plantTypeName = plantTypeTextField?.text else {return}
                
                PlantTypeController.shared.update(plantType: plantTypeToEdit, newTitle: plantTypeName)
                self.tableView.reloadData()
            }
            alert.addAction(cancel)
            alert.addAction(save)
            self.present(alert, animated: true, completion: nil)
            completion(true)
        }
        return action
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlantTypeController.shared.plantTypes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "plantTypeCell", for: indexPath)
        let plantType = PlantTypeController.shared.plantTypes[indexPath.row]
        cell.textLabel?.text = plantType.type
        return cell
    }

     // MARK: - Navigation
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWater_FeedVC",
            let indexPath = tableView.indexPathForSelectedRow {
            let plantType = PlantTypeController.shared.plantTypes[indexPath.row]
            let plantTypeDetailVC = segue.destination as? PlantTypeDetailViewController
            plantTypeDetailVC?.plantType = plantType
        }
     }
}
