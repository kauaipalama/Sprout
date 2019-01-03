//
//  PlantHealthViewController.swift
//  Sprout
//
//  Created by Kainoa Palama on 4/19/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//
//TODO:
//Keyboard observer to shift keyboard up. ADD

//*****Wont save when parts of record are missing. ie: photo. FIX OR ALERT******
//Alert the user know they still need to input values if they try to save before doing so.

//For dark theme use a off white yellowish type of color for the textViews
//Check constraints

import UIKit

protocol PlantHealthDetailControllerDelegate: class {
    func photoSelectViewControllerSelected(_ image: UIImage)
}

class PlantHealthViewController: ShiftableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    // MARK: - Life Cycle
    
    override func viewDidAppear(_ animated: Bool) {
        print(self.view.frame.origin.y)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        updateViews()
        plantHealthNotesTextView.delegate = self
        print(self.view.frame.origin.y)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return SproutTheme.current.preferredStatusBarStyle
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clearPlaceholderText()
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (_) in
            self.createGradientLayer()
            self.plantHealthBar.addSubview(self.poorHealthLabel)
            self.plantHealthBar.addSubview(self.excellantHealthLabel)
        }
    }
    
    // MARK: - Views
    
    func setupViews() {
        view.backgroundColor = SproutTheme.current.backgroundColor
        
        oneButton.tintColor = SproutTheme.current.health1Color
        twoButton.tintColor = SproutTheme.current.health2Color
        threeButton.tintColor = SproutTheme.current.health3Color
        fourButton.tintColor = SproutTheme.current.health4Color
        fiveButton.tintColor = SproutTheme.current.health5Color
        
        plantHealthNotesTextView.inputAccessoryView = keyboardToolbar
        
        keyboardToolbar.barStyle = .default
        keyboardToolbar.isTranslucent = true
        keyboardToolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        keyboardToolbar.setItems([flexibleSpace, doneButton], animated: false)
        
        plantHealthNotesTextView.placeholderLabel.textAlignment = .center
        plantHealthNotesTextView.layer.borderWidth = 1
        plantHealthNotesTextView.layer.borderColor = SproutTheme.current.accentColor.cgColor
        plantHealthNotesTextView.layer.cornerRadius = 6
        
        plantHealthBar.layer.cornerRadius = 6
        thumbnailImageView.layer.cornerRadius = 6
    }
    
    func createGradientLayer(){
        gradientLayer = CAGradientLayer()
        
        _ = plantHealthBar.bounds
        gradientLayer.frame = CGRect(x: 0, y: 0, width: plantHealthBar.frame.size.width, height: plantHealthBar.frame.size.height)
        gradientLayer.colors = [SproutTheme.current.health1Color.cgColor,SproutTheme.current.health2Color.cgColor,SproutTheme.current.health3Color.cgColor,SproutTheme.current.health4Color.cgColor,SproutTheme.current.health5Color.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        self.plantHealthBar.layer.addSublayer(gradientLayer)
    }
    
    func setPlantHealthButtons(plantHealth: Int) {
        switch plantHealth {
        case 1:
            oneButton.backgroundColor = #colorLiteral(red: 0.8823529412, green: 0.4980392157, blue: 0.431372549, alpha: 1)
            twoButton.backgroundColor = UIColor.lightGray
            threeButton.backgroundColor = UIColor.lightGray
            fourButton.backgroundColor = UIColor.lightGray
            fiveButton.backgroundColor = UIColor.lightGray
            
        case 2:
            oneButton.backgroundColor = UIColor.lightGray
            twoButton.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.7137254902, blue: 0.4941176471, alpha: 1)
            threeButton.backgroundColor = UIColor.lightGray
            fourButton.backgroundColor = UIColor.lightGray
            fiveButton.backgroundColor = UIColor.lightGray
            
        case 3:
            oneButton.backgroundColor = UIColor.lightGray
            twoButton.backgroundColor = UIColor.lightGray
            threeButton.backgroundColor = #colorLiteral(red: 1, green: 0.9764705882, blue: 0.5882352941, alpha: 1)
            fourButton.backgroundColor = UIColor.lightGray
            fiveButton.backgroundColor = UIColor.lightGray
            
        case 4:
            oneButton.backgroundColor = UIColor.lightGray
            twoButton.backgroundColor = UIColor.lightGray
            threeButton.backgroundColor = UIColor.lightGray
            fourButton.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9803921569, blue: 0.5803921569, alpha: 1)
            fiveButton.backgroundColor = UIColor.lightGray
            
        case 5:
            oneButton.backgroundColor = UIColor.lightGray
            twoButton.backgroundColor = UIColor.lightGray
            threeButton.backgroundColor = UIColor.lightGray
            fourButton.backgroundColor = UIColor.lightGray
            fiveButton.backgroundColor = #colorLiteral(red: 0.6666666667, green: 0.9137254902, blue: 0.5411764706, alpha: 1)
            
        default:
            oneButton.backgroundColor = #colorLiteral(red: 0.8823529412, green: 0.4980392157, blue: 0.431372549, alpha: 1)
            twoButton.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.7137254902, blue: 0.4941176471, alpha: 1)
            threeButton.backgroundColor = #colorLiteral(red: 1, green: 0.9764705882, blue: 0.5882352941, alpha: 1)
            fourButton.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9803921569, blue: 0.5803921569, alpha: 1)
            fiveButton.backgroundColor = #colorLiteral(red: 0.6666666667, green: 0.9137254902, blue: 0.5411764706, alpha: 1)
        }
    }
    
    func updateViews() {
        guard let plantType = plantType else { return }
        
        if let day = PlantTypeController.shared.fetchDayFor(plantType: plantType) {
            
            self.day = day
            
            plantHealthNotesTextView.text = day.plantRecord?.plantHealthNotes
            plantHealth = day.plantRecord?.plantHealth
            guard let imageData = day.plantRecord?.plantImage else {return}
            self.imageData = imageData
            plantPhoto = UIImage(data: imageData)
            thumbnailImageView.image = plantPhoto
            guard let plantRecord = day.plantRecord else {return}
            setPlantHealthButtons(plantHealth: Int(plantRecord.plantHealth))
            
        }
    }
    
    
    // MARK: - Helper function
    
    func clearPlaceholderText() {
        if !plantHealthNotesTextView.text.isEmpty {
            plantHealthNotesTextView.placeholder = ""
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    
    @IBOutlet weak var plantHealthNotesTextView: PlaceholderTextView!
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var plantHealthBar: UIView!
    @IBOutlet weak var poorHealthLabel: UILabel!
    @IBOutlet weak var excellantHealthLabel: UILabel!
    
    // MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let plantHealthNotes = plantHealthNotesTextView.text,
            let plantHealth = plantHealth,
            let imageData = imageData
            else {return}
        
        //Set a default image here so that it doesnt return in updateViews in PlantRecordVC
        //Use if let statement with imageData and set default with default image data?
        //Tried using an optional for imageData but the updatePlantRecordHealth does not allow for a optional
        //See if the notes are blank. If they are display N/A
        
        if let plantRecord = day?.plantRecord {
            PlantRecordController.shared.updatePlantRecordHealth(plantHealth: plantHealth, plantHealthNotes: plantHealthNotes, plantImage: imageData, plantRecord: plantRecord)
        } else {
            guard let day = self.day else { return }
            let plantRecord = PlantRecordController.shared.createBlankPlantRecordFor(days: day)
            PlantRecordController.shared.updatePlantRecordHealth(plantHealth: plantHealth, plantHealthNotes: plantHealthNotes, plantImage: imageData, plantRecord: plantRecord)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @objc func doneButtonTapped() {
        plantHealthNotesTextView.resignFirstResponder()
    }
    
    @IBAction func oneButtonTapped(_ sender: Any) {
        print("one button tapped")
        plantHealth = 1
        setPlantHealthButtons(plantHealth: 1)
    }
    
    @IBAction func twoButtonTapped(_ sender: Any) {
        print("two button tapped")
        plantHealth = 2
        setPlantHealthButtons(plantHealth: 2)
    }
    
    @IBAction func threeButtonTapped(_ sender: Any) {
        print("three button tapped")
        plantHealth = 3
        setPlantHealthButtons(plantHealth: 3)
    }
    
    @IBAction func fourButtonTapped(_ sender: Any) {
        print("four button tapped")
        plantHealth = 4
        setPlantHealthButtons(plantHealth: 4)
    }
    
    @IBAction func fiveButtonTapped(_ sender: Any) {
        print("five button tapped")
        plantHealth = 5
        setPlantHealthButtons(plantHealth: 5)
    }
    
    
    @IBAction func cameraButtonTapped(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alert = UIAlertController(title: "Select Photo Location", message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (_) -> Void in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            }))
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) -> Void in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }))
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhotoDetail" {
            let plantPhoto = self.plantPhoto
            let photoDetailVC = segue.destination as? PhotoDetailViewController
            photoDetailVC?.plantPhoto = plantPhoto
        }
    }
    
    // MARK: - Delegatation
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
            
            self.imageData = image.jpegData(compressionQuality: 0.9)
            self.plantPhoto = image
            delegate?.photoSelectViewControllerSelected(image)
            thumbnailImageView.image = image
            
        }
    }
    
    // MARK: - Properties
    
    weak var delegate: PlantHealthDetailControllerDelegate?
    var plantType: PlantType?
    var plantHealth: Int16? = 0
    var imageData: Data?
    var plantPhoto: UIImage?
    var day: Day?
    
    var gradientLayer: CAGradientLayer!
    
    var keyboardToolbar = UIToolbar()
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
