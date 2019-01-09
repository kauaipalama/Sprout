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

//Alert the user know they still need to input values if they try to save before doing so.

//Add ability for views to change with theme

//For dark theme use a off white yellowish type of color for the textViews
//Check constraints

import UIKit

class Water_FeedViewController: ShiftableViewController {
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        updateViews()
        print(self.view.frame.origin.y)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clearPlaceholderText()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return SproutTheme.current.preferredStatusBarStyle
    }
    
    // MARK: - Views
    
    func setupViews() {
        view.backgroundColor = SproutTheme.current.backgroundColor
        
        conductivityLabel.textColor = SproutTheme.current.textColor
        conductivityTextField.layer.borderColor = SproutTheme.current.accentColor.cgColor
        conductivityTextField.keyboardType = UIKeyboardType.decimalPad
        phLabel.textColor = SproutTheme.current.textColor
        phTextField.layer.borderColor = SproutTheme.current.accentColor.cgColor
        phTextField.keyboardType = UIKeyboardType.decimalPad
        volumeLabel.textColor = SproutTheme.current.textColor
        volumeTextField.layer.borderColor = SproutTheme.current.accentColor.cgColor
        volumeTextField.keyboardType = UIKeyboardType.decimalPad
        water_FeedNotesLabel.textColor = SproutTheme.current.textColor
        
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
        water_FeedNotesTextView.delegate = self
        
    }
    
    
    func updateViews() {
        guard let plantType = plantType else { return }
        
        if let day = PlantTypeController.shared.fetchDayFor(plantType: plantType) {
            self.day = day
            conductivityTextField.text = day.plantRecord?.conductivityString
            phTextField.text = day.plantRecord?.phString
            volumeTextField.text = day.plantRecord?.volumeString
            water_FeedNotesTextView.text = day.plantRecord?.water_feedNotes
        }
    }
    
    func clearPlaceholderText() {
        if !water_FeedNotesTextView.text.isEmpty {
            water_FeedNotesTextView.placeholder = ""
        }
    }
    
    @objc func doneButtonTapped() {
        conductivityTextField.resignFirstResponder()
        phTextField.resignFirstResponder()
        volumeTextField.resignFirstResponder()
        water_FeedNotesTextView.resignFirstResponder()
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var conductivityLabel: UILabel!
    @IBOutlet weak var conductivityTextField: UITextField!
    @IBOutlet weak var phLabel: UILabel!
    @IBOutlet weak var phTextField: UITextField!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var volumeTextField: UITextField!
    @IBOutlet weak var water_FeedNotesTextView: PlaceholderTextView!
    @IBOutlet weak var water_FeedNotesLabel: UILabel!
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
    
    
    // MARK: - Properties
    
    var plantType: PlantType?
    var keyboardToolbar = UIToolbar()
    var day: Day?
    
    // MARK: - Notification Center
    
    }
