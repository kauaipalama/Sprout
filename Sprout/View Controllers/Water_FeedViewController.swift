//
//  Water_FeedViewController.swift
//  Sprout
//
//  Created by Kainoa Palama on 4/19/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//

//TODO:
//Keyboard observer to shift view up 

import UIKit

class Water_FeedViewController: UIViewController {
    
    // MARK: - Properties
    var plantType: PlantType?
    var keyboardToolbar = UIToolbar()
    var day: Day?
    
    // MARK: - Outlets
    @IBOutlet weak var conductivityTextField: UITextField!
    @IBOutlet weak var phTextField: UITextField!
    @IBOutlet weak var volumeTextField: UITextField!
    @IBOutlet weak var water_FeedNotesTextView: PlaceholderTextView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clearPlaceholderText()
    }
    
    // MARK: - Update Views
    
    func updateViews() {
        guard let plantType = plantType else { return }
        
        if let day = PlantTypeController.shared.fetchDayFor(plantType: plantType) {
            
            self.day = day
            
            conductivityTextField.text = day.plantRecord?.conductivity.description
                    phTextField.text = day.plantRecord?.ph.description
                    volumeTextField.text = day.plantRecord?.volume.description
                    water_FeedNotesTextView.text = day.plantRecord?.water_feedNotes
        }
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
        
        water_FeedNotesTextView.placeholderLabel.textAlignment = .center
        water_FeedNotesTextView.layer.borderWidth = 1
        water_FeedNotesTextView.layer.borderColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 0.4).cgColor
        water_FeedNotesTextView.layer.cornerRadius = 6
    }
    
    // MARK: - Helper Functions
    
    func clearPlaceholderText() {
        if !water_FeedNotesTextView.text.isEmpty {
            water_FeedNotesTextView.placeholder = ""
        }
    }
    
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
    
    // MARK: - Keyboard Notification Center
    
    }
