//
//  Water_FeedViewController.swift
//  Sprout
//
//  Created by Kainoa Palama on 4/19/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//

//TODO:
//For dark theme use a off white yellowish type of color for the textViews

//CHECK ME

import UIKit

class Water_FeedViewController: ShiftableViewController {
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        updateViews()
        
        if day?.plantRecord?.conductivity == nil && day?.plantRecord?.ph == nil && day?.plantRecord?.volume == nil {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            self.navigationItem.rightBarButtonItem?.tintColor = .clear
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clearPlaceholderText()
    }
    
//        override func viewDidAppear(_ animated: Bool) {
//            super.viewDidAppear(true)
//            if phTextField.isEditing == true || conductivityTextField.isEditing == true || volumeTextField.isEditing == true {
//                self.navigationItem.rightBarButtonItem?.isEnabled = false
//                self.navigationItem.rightBarButtonItem?.tintColor = .clear
//            }
//        }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return SproutTheme.current.preferredStatusBarStyle
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    // MARK: - Views
    
    func setupViews() {
        view.backgroundColor = SproutTheme.current.backgroundColor
        
        conductivityTextField.layer.borderColor = SproutTheme.current.accentColor.cgColor
        conductivityTextField.keyboardType = UIKeyboardType.decimalPad
        conductivityTextField.placeholder = "Enter \(SproutPreferencesController.shared.conductivityUnitString)"
        conductivityTextField.backgroundColor = SproutTheme.current.textFieldBackgroundColor
        phTextField.layer.borderColor = SproutTheme.current.accentColor.cgColor
        phTextField.keyboardType = UIKeyboardType.decimalPad
        phTextField.backgroundColor = SproutTheme.current.textFieldBackgroundColor
        volumeTextField.layer.borderColor = SproutTheme.current.accentColor.cgColor
        volumeTextField.keyboardType = UIKeyboardType.decimalPad
        volumeTextField.backgroundColor = SproutTheme.current.textFieldBackgroundColor
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
        water_FeedNotesTextView.backgroundColor = SproutTheme.current.textFieldBackgroundColor
        water_FeedNotesTextView.layer.cornerRadius = 6
        
        if self.view.frame.height >= 1024 {
            water_FeedNotesTextView.delegate = nil
        } else {
            water_FeedNotesTextView.delegate = self
        }
        volumeTextField.delegate = self
        phTextField.delegate = self
        conductivityTextField.delegate = self
        
    }
    
    
    func updateViews() {
        guard let plantType = plantType else { return }
        
        if let day = PlantTypeController.shared.fetchDayFor(plantType: plantType) {
            self.day = day
            conductivityTextField.text = day.plantRecord?.conductivityString
            phTextField.text = day.plantRecord?.phString
            volumeTextField.text = day.plantRecord?.volumeString
            water_FeedNotesTextView.text = day.plantRecord?.water_feedNotes
            
            conductivity = day.plantRecord?.conductivity
            ph = day.plantRecord?.ph
            volume = day.plantRecord?.volume
        }
    }
    
    func clearPlaceholderText() {
        if !water_FeedNotesTextView.text.isEmpty {
            water_FeedNotesTextView.placeholder = ""
        }
    }
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        print("did begin editing")
        //        textField.text = ""
        if textField == conductivityTextField && textField.text == "" {
            textFieldPrefix = "\(SproutPreferencesController.shared.conductivityUnitString): "
            textField.text = textFieldPrefix
            //            textFieldPrefix = nil
        } else if textField == phTextField && textField.text == "" {
            textFieldPrefix = "PH: "
            textField.text = textFieldPrefix
            //            textFieldPrefix = nil
        } else if textField == volumeTextField {
            //FIXES BUG where textFieldPrefix will not pop up. And there is no textFieldBeingEditied where I could set the textfield.text if the text was empty. Crude fix by clearing the text when user enters field.
            textField.text = ""
            textFieldPrefix = "\(SproutPreferencesController.shared.volumeUnitString): "
            textField.text = textFieldPrefix
            //            textFieldPrefix = nil
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        print("did end editing")
        if phTextField.text?.isEmpty == false && conductivityTextField.text?.isEmpty == false && volumeTextField.text?.isEmpty == false {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            self.navigationItem.rightBarButtonItem?.tintColor = SproutTheme.current.tintedTextColor
        }
        
        if textField.text == SproutPreferencesController.shared.conductivityUnitString + ": " || textField.text == SproutPreferencesController.shared.volumeUnitString + ": " || textField.text == "PH: " {
            textField.text = ""
        }
        
        if textField == phTextField {
            //Force Unwrapped. Fix later
            tempPhString = "\(phTextField.text!.dropFirst(4))"
        } else if textField == conductivityTextField {
            //Force Unwrapped. Fix later
            tempConductivityString = "\(conductivityTextField.text!.dropFirst(SproutPreferencesController.shared.conductivityUnitString.count + 2))"
        } else if textField == volumeTextField {
            //Force Unwrapped. Fix later
            tempVolumeString = "\(volumeTextField.text!.dropFirst(SproutPreferencesController.shared.volumeUnitString.count + 2))"
        }
    }
    
    @objc func doneButtonTapped() {
        conductivityTextField.resignFirstResponder()
        phTextField.resignFirstResponder()
        volumeTextField.resignFirstResponder()
        water_FeedNotesTextView.resignFirstResponder()
    }
    
    @objc func keyboardWillChangeFrame(notification: Notification) {
        print("Keyboard did change frame")
        var keyboardSize: CGRect = .zero
        var keyboardAnimationDuration: Double = 0.0
        
        if let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            keyboardAnimationDuration = animationDuration
        }
        
        
        
        if let keyboardRect = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            keyboardRect.height != 0 {
            keyboardSize = keyboardRect
        } else if let keyboardRect = notification.userInfo?["UIKeyboardBoundsUserInfoKey"] as? CGRect {
            keyboardSize = keyboardRect
        }
        
        if self.view.frame.origin.y == 0 && textViewBeingEdited == water_FeedNotesTextView {
            UIView.animate(withDuration: keyboardAnimationDuration + 1.5) {
                self.view.layoutIfNeeded()
                print(self.view.frame.height)
                //*Just add specifics
                //iPads
                
                if self.view.frame.height <= 568 {
                    //iPhone SE (568)
                    self.water_FeedNotesTextViewTopConstraint.constant = keyboardSize.height / 2.1
                } else if self.view.frame.height <= 667 {
                    //iPhone8 (667)
                    self.water_FeedNotesTextViewTopConstraint.constant = keyboardSize.height / 2.05
                } else if self.view.frame.height <= 763 {
                    //iPhone8 Plus (763)
                    self.water_FeedNotesTextViewTopConstraint.constant = keyboardSize.height / 1.95
                } else if self.view.frame.height <= 812 {
                    //iPhoneX (812)
                    self.water_FeedNotesTextViewTopConstraint.constant = keyboardSize.height / 1.7
                    self.water_FeedNotesTextViewBottomConstraint.constant = -(self.view.safeAreaInsets.bottom) + 8
                } else if self.view.frame.height <= 896 {
                    //iPhoneXSMax (896)
                    self.water_FeedNotesTextViewTopConstraint.constant = keyboardSize.height / 1.67
                    self.water_FeedNotesTextViewBottomConstraint.constant = -(self.view.safeAreaInsets.bottom) + 8
                }
            }
        } else {
            UIView.animate(withDuration: keyboardAnimationDuration + 1.5) {
                self.view.layoutIfNeeded()
                self.water_FeedNotesTextViewTopConstraint.constant = 8
                self.water_FeedNotesTextViewBottomConstraint.constant = 8
            }
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var conductivityTextField: UITextField!
    @IBOutlet weak var phTextField: UITextField!
    @IBOutlet weak var volumeTextField: UITextField!
    @IBOutlet weak var water_FeedNotesTextView: PlaceholderTextView!
    @IBOutlet weak var water_FeedNotesTextViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var water_FeedNotesTextViewBottomConstraint: NSLayoutConstraint!
    
    
    // MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        conductivityTextField.resignFirstResponder()
        volumeTextField.resignFirstResponder()
        phTextField.resignFirstResponder()
        if conductivityTextField.text == "" || conductivityTextField.text == "N/A"||phTextField.text == "" || phTextField.text == "N/A" || volumeTextField.text == "" || volumeTextField.text == "N/A" {
            let alert = UIAlertController(title: "Before you go", message: "-Enter Conductivity \n-Enter pH \n-Enter Volume \n\nOptional: \n-Take Notes", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated:  true, completion: nil)
        }
        
        
        //Take constants which represent "temp" strings, outside the scope of this function.
        //BUG: Cannot update water_feedVC
        //Going to let it pass for now. Bug is very hard to replicate.
        guard let phString = tempPhString,
            let ph = Float(phString),
            let conductivityString = tempConductivityString,
            let conductivity = Float(conductivityString),
            //Breaks here for some reason
            let volumeString = tempVolumeString,
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
    var conductivity: Float?
    var ph: Float?
    var volume: Float?
    var textFieldPrefix: String?
    var tempConductivityString: String?
    var tempPhString: String?
    var tempVolumeString: String?
    
    // MARK: - Notification Center
    
}
