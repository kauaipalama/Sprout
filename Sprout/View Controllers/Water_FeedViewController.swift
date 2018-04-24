//
//  Water_FeedViewController.swift
//  Sprout
//
//  Created by Kainoa Palama on 4/19/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//

//Added keyboard toolbar with done button

//TODO:
//Fetch record for update views for when coming back to view
//Keyboard observer to shift view up 

import UIKit

class Water_FeedViewController: UIViewController {
    
    // MARK: - Properties
    var plantType: PlantType?
    var keyboardToolbar = UIToolbar()
    
    // MARK: - Outlets
    @IBOutlet weak var conductivityTextField: UITextField!
    @IBOutlet weak var phTextField: UITextField!
    @IBOutlet weak var volumeTextField: UITextField!
    @IBOutlet weak var water_FeedNotesTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        updateViews()
    }
    
    // MARK: - Update Views
    
    func updateViews() {
        guard let plantType = plantType,
            let plantRecord = PlantTypeController.shared.plantRecordsFor(plantType: plantType, forDate: Date()).first else { return }
        
        conductivityTextField.text = plantRecord.conductivity.description
        phTextField.text = plantRecord.ph.description
        volumeTextField.text = plantRecord.volume.description
        water_FeedNotesTextView.text = plantRecord.water_feedNotes
    }
    
    // MARK: - Setup Views
    
    func setupViews() {
        conductivityTextField.inputAccessoryView = keyboardToolbar
        phTextField.inputAccessoryView = keyboardToolbar
        volumeTextField.inputAccessoryView = keyboardToolbar
        water_FeedNotesTextView.inputAccessoryView = keyboardToolbar
        
        keyboardToolbar.barStyle = .default
        keyboardToolbar.isTranslucent = true
        keyboardToolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        keyboardToolbar.setItems([flexibleSpace, doneButton], animated: false)
    }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let plantType = plantType,
            let phString = phTextField.text,
            let ph = Float(phString),
            let conductivityString = conductivityTextField.text,
            let conductivity = Float(conductivityString),
            let volumeString = volumeTextField.text,
            let volume = Float(volumeString),
            let water_feedNotes = water_FeedNotesTextView.text
            else {return}
        
        if let plantRecord = PlantTypeController.shared.plantRecordsFor(plantType: plantType, forDate: Date()).first {
            PlantRecordController.shared.updatePlantRecordWater_Feed(ph: ph, conductivity: conductivity, volume: volume, water_feedNotes: water_feedNotes, plantRecord: plantRecord)
        } else {
            let plantRecord = PlantRecordController.shared.createBlankPlantRecordFor(plantType: plantType)
            PlantRecordController.shared.updatePlantRecordWater_Feed(ph: ph, conductivity: conductivity, volume: volume, water_feedNotes: water_feedNotes, plantRecord: plantRecord)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @objc func doneButtonTapped() {
        conductivityTextField.resignFirstResponder()
        phTextField.resignFirstResponder()
        volumeTextField.resignFirstResponder()
        water_FeedNotesTextView.resignFirstResponder()
    }
    
    // MARK: - Keyboard Notification Center
    
    }
