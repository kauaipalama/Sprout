//
//  PlantTypeViewController.swift
//  Sprout
//
//  Created by Kainoa Palama on 11/7/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//
//Needs a gesture which closes menu when touched outside view.
//Instead of using an alertController when adding a plant type. Use a modal presentation OR present the view similarly to how it was presented for the menuView. Text field. Rounded views. Like an alert controller but prettier and soft. OR add a blank cell and present keyboard when add button tapped and show the text as it is typed in. save and cancel on keyboard.

import UIKit

class PlantTypeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        setupSubViews()
        tableview.reloadData()
        blurView.effect = SproutTheme.current.blurEffect
        print(self.view.frame.origin.y)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
        setupSubViews()
        print(self.view.frame.origin.y)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(self.view.frame.origin.y)
    }
    
    func setupInitialView() {
        self.view.sendSubviewToBack(blurView)
        blurView.effect = nil
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return SproutTheme.current.preferredStatusBarStyle
    }
    
    @IBAction func blurViewTapped(_ sender: UITapGestureRecognizer) {
        closeMenu()
    }
    
    func setupSubViews() {
        
        navigationController?.navigationBar.barTintColor = SproutTheme.current.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: SproutTheme.current.textColor]

        menuView.layer.shadowOpacity = 0.3
        menuView.layer.shadowRadius = 6
        menuView.backgroundColor = SproutTheme.current.backgroundColor
        
        menuAboutButton.titleLabel?.textColor = SproutTheme.current.textColor
        menuPreferencesButton.titleLabel?.textColor = SproutTheme.current.textColor
        menuHelpButton.titleLabel?.textColor = SproutTheme.current.textColor
        
        tableview.backgroundColor = SproutTheme.current.backgroundColor
        tableview.separatorColor = UIColor.clear
    }
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var menuAboutButton: UIButton!
    @IBOutlet weak var menuPreferencesButton: UIButton!
    @IBOutlet weak var menuHelpButton: UIButton!
    
    func openMenu() {
        menuViewTopConstraint.constant = 0
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.tintColor = .clear
        navigationItem.title = "Main Menu"
        blurView.isUserInteractionEnabled = true
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.view.insertSubview(self.blurView, at: 1)
            self.blurView.effect = SproutTheme.current.blurEffect
            self.menuAboutButton.titleLabel?.textColor = SproutTheme.current.textColor
            self.menuPreferencesButton.titleLabel?.textColor = SproutTheme.current.textColor
            self.menuHelpButton.titleLabel?.textColor = SproutTheme.current.textColor
        }
    }
    
    func closeMenu() {
        menuViewTopConstraint.constant = -167
        navigationItem.rightBarButtonItem?.isEnabled = true
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.4, green: 0.6235294118, blue: 0.9411764706, alpha: 1)
        navigationItem.title = "Plants"
        blurView.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
            self.blurView.effect = nil
            self.menuAboutButton.titleLabel?.textColor = SproutTheme.current.textColor
            self.menuPreferencesButton.titleLabel?.textColor = SproutTheme.current.textColor
            self.menuHelpButton.titleLabel?.textColor = SproutTheme.current.textColor
        }) { (_) in
            self.view.insertSubview(self.blurView, at: 0)
        }

    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        if menuIsOpen == false {
            openMenu()
            menuIsOpen = true
    
        } else {
            closeMenu()
            menuIsOpen = false
        }
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        var newPlantTypeTextField: UITextField?
        
        let alert = UIAlertController(title: "Add Plant Type", message: "Name of New Plant Type", preferredStyle: .alert)
        
        alert.addTextField {(textfield) in newPlantTypeTextField = textfield}
        
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let save = UIAlertAction(title: "Save", style: .default) { (_) in
            guard let plantTypeName = newPlantTypeTextField?.text else {return}
            
            PlantTypeController.shared.create(plantType: plantTypeName)
            self.tableview.reloadData()
        }
        alert.addAction(cancel)
        alert.addAction(save)
        present(alert, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        let edit = editAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete, edit])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            let plantTypeToDelete = PlantTypeController.shared.plantTypes[indexPath.row]
            PlantTypeController.shared.delete(plantType: plantTypeToDelete)
            self.tableview.deleteRows(at: [indexPath], with: .fade)
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
                self.tableview.reloadData()
            }
            alert.addAction(cancel)
            alert.addAction(save)
            self.present(alert, animated: true, completion: nil)
            completion(true)
        }
        return action
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlantTypeController.shared.plantTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "plantTypeCell", for: indexPath)
        let plantType = PlantTypeController.shared.plantTypes[indexPath.row]
        cell.textLabel?.text = plantType.type
        cell.textLabel?.textColor = SproutTheme.current.textColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPlantTypeDetailVC",
            let indexPath = tableview.indexPathForSelectedRow {
            let plantType = PlantTypeController.shared.plantTypes[indexPath.row]
            let plantTypeDetailVC = segue.destination as? PlantTypeDetailViewController
            plantTypeDetailVC?.plantType = plantType
        }
    }
    
    var menuIsOpen: Bool = false
}
