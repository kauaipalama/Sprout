//
//  Water_FeedViewController.swift
//  Sprout
//
//  Created by Kainoa Palama on 4/19/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//

//TODO:
//??When view loads after partial record saved. It loads with 0.0. If record is partial load with placeholder. FIX??

//Alert the user know they still need to input values if they try to save before doing so.

//For dark theme use a off white yellowish type of color for the textViews

//Bigger texts fields. Think Jitterbug.

import UIKit

class Water_FeedViewController: ShiftableViewController {
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        updateViews()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clearPlaceholderText()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return SproutTheme.current.preferredStatusBarStyle
    }
    
    //    override func keyboardWillShow(notification: Notification) {
    //        //Animate the top constraint of the textView's label to better match the screen.
    //        //Modify the constraints multiplier to around 1.355. Check and adjust
    //    }
    //
    //    override func keyboardWillHide(notification: Notification) {
    //        //Animate the bottom constraint again back to 0.
    //    }
    
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
        
        if self.view.frame.origin.y == 0 {
            UIView.animate(withDuration: keyboardAnimationDuration) {
                self.view.layoutIfNeeded()
                self.water_FeedNotesLabelTopConstraint.constant = keyboardSize.height/3.3
            }
        } else {
            UIView.animate(withDuration: keyboardAnimationDuration) {
                self.view.layoutIfNeeded()
                self.water_FeedNotesLabelTopConstraint.constant = 10
            }
        }
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
    @IBOutlet weak var water_FeedNotesLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var water_FeedNotesTextViewBottomConstraint: NSLayoutConstraint!
    
    
    // MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if conductivityTextField.text == "" || conductivityTextField.text == "N/A"||phTextField.text == "" || phTextField.text == "N/A" || volumeTextField.text == "" || volumeTextField.text == "N/A" {
            let alert = UIAlertController(title: "Before you go", message: "-Enter Conductivity \n-Enter pH \n-Enter Volume \n\nOptional: \n-Take Notes", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated:  true, completion: nil)
        }
        
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
