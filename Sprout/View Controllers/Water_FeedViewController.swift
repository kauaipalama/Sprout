//
//  Water_FeedViewController.swift
//  Sprout
//
//  Created by Kainoa Palama on 4/19/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//

//TODO:
//Keyboard observer to shift view up. ADD
//When view loads after partial record saved. It loads with 0.0. If record is partial load with placeholder. FIX

// Setup preferences and use to populate volumeTextField with the value followed by " gallons" or liters whatever you set it as in preferences pane.
// Setup preferences to change between ppm 500, ppm700 and EC labels

import UIKit

class Water_FeedViewController: ShiftableViewController {
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        updateViews()
        water_FeedNotesTextView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clearPlaceholderText()
    }
    
    // MARK: - Views
    
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
        
        water_FeedNotesTextView.placeholderLabel.textAlignment = .center
        water_FeedNotesTextView.layer.borderWidth = 1
        water_FeedNotesTextView.layer.borderColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 0.4).cgColor
        water_FeedNotesTextView.layer.cornerRadius = 6
    }
    
    func updateViews() {
        guard let plantType = plantType else { return }
        
        if let day = PlantTypeController.shared.fetchDayFor(plantType: plantType) {
            
            self.day = day
            //Make the text field for ph and volume only have one digit after decimal. rounded
            conductivityTextField.text = day.plantRecord?.conductivityString
            phTextField.text = day.plantRecord?.phString
            volumeTextField.text = day.plantRecord?.volumeString
            water_FeedNotesTextView.text = day.plantRecord?.water_feedNotes
        }
    }
    
    
    // MARK: - Helper function
    
    func clearPlaceholderText() {
        if !water_FeedNotesTextView.text.isEmpty {
            water_FeedNotesTextView.placeholder = ""
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var conductivityTextField: UITextField!
    @IBOutlet weak var phTextField: UITextField!
    @IBOutlet weak var volumeTextField: UITextField!
    @IBOutlet weak var water_FeedNotesTextView: PlaceholderTextView!
    
    // MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let phString = phTextField.text,
            let ph = Float(phString),
            let conductivityString = conductivityTextField.text,
            let conductivity = Float(conductivityString),
            let volumeString = volumeTextField.text,
            let volume = Float(volumeString),
            let water_feedNotes = water_FeedNotesTextView.text
            else {return}
        
        if let plantRecord = day?.plantRecord {
            PlantRecordController.shared.updatePlantRecordWater_Feed(ph: ph, conductivity: conductivity, volume: volume, water_feedNotes: water_feedNotes, plantRecord: plantRecord)
        } else {
            guard let day = self.day else { return }
            let plantRecord = PlantRecordController.shared.createBlankPlantRecordFor(days: day)
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
    
    // MARK: - Properties
    
    var plantType: PlantType?
    var keyboardToolbar = UIToolbar()
    var day: Day?
    
    // MARK: - Notification Center
    
    }
