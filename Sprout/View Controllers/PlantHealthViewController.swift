//
//  PlantHealthViewController.swift
//  Sprout
//
//  Created by Kainoa Palama on 4/19/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//
//TODO:
//Keyboard observer to shift keyboard up

import UIKit

protocol PlantHealthDetailControllerDelegate: class {
    func photoSelectViewControllerSelected(_ image: UIImage)
}

class PlantHealthViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Properties
    weak var delegate: PlantHealthDetailControllerDelegate?
    var plantType: PlantType?
    var plantHealth: Int16? = 0
    var imageData: Data?
    var plantPhoto: UIImage?
    var day: Day?
    
    var keyboardToolbar = UIToolbar()
    
    // MARK: - Update Views
    
    func updateViews() {
        guard let plantType = plantType else { return }
        
        if let day = PlantTypeController.shared.fetchDayFor(plantType: plantType) {
            
            self.day = day
            
            plantHealthNotesTextView.text = day.plantRecord?.plantHealthNotes
            plantHealth = day.plantRecord?.plantHealth
            guard let imageData = day.plantRecord?.plantImage else {return}
            plantPhoto = UIImage(data: imageData)
            thumbnailImageView.image = plantPhoto
            guard let plantRecord = day.plantRecord else {return}
            setPlantHealthButtons(plantHealth: Int(plantRecord.plantHealth))
        }
    }
    
    // MARK: - Setup Views
    func setupViews() {
        plantHealthNotesTextView.inputAccessoryView = keyboardToolbar
        
        keyboardToolbar.barStyle = .default
        keyboardToolbar.isTranslucent = true
        keyboardToolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        keyboardToolbar.setItems([flexibleSpace, doneButton], animated: false)
        
    }
    
    func setPlantHealthButtons(plantHealth: Int) {
        switch plantHealth {
        case 1:
            oneButton.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            twoButton.backgroundColor = UIColor.lightGray
            threeButton.backgroundColor = UIColor.lightGray
            fourButton.backgroundColor = UIColor.lightGray
            fiveButton.backgroundColor = UIColor.lightGray
            
        case 2:
            oneButton.backgroundColor = UIColor.lightGray
            twoButton.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            threeButton.backgroundColor = UIColor.lightGray
            fourButton.backgroundColor = UIColor.lightGray
            fiveButton.backgroundColor = UIColor.lightGray
            
        case 3:
            oneButton.backgroundColor = UIColor.lightGray
            twoButton.backgroundColor = UIColor.lightGray
            threeButton.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
            fourButton.backgroundColor = UIColor.lightGray
            fiveButton.backgroundColor = UIColor.lightGray
            
        case 4:
            oneButton.backgroundColor = UIColor.lightGray
            twoButton.backgroundColor = UIColor.lightGray
            threeButton.backgroundColor = UIColor.lightGray
            fourButton.backgroundColor = #colorLiteral(red: 0.8493849635, green: 1, blue: 0, alpha: 1)
            fiveButton.backgroundColor = UIColor.lightGray
            
        case 5:
            oneButton.backgroundColor = UIColor.lightGray
            twoButton.backgroundColor = UIColor.lightGray
            threeButton.backgroundColor = UIColor.lightGray
            fourButton.backgroundColor = UIColor.lightGray
            fiveButton.backgroundColor = #colorLiteral(red: 0, green: 0.9275812507, blue: 0.03033527173, alpha: 1)
            
        default:
            oneButton.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            twoButton.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            threeButton.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
            fourButton.backgroundColor = #colorLiteral(red: 0.8493849635, green: 1, blue: 0, alpha: 1)
            fiveButton.backgroundColor = #colorLiteral(red: 0, green: 0.9275812507, blue: 0.03033527173, alpha: 1)
            
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    
    @IBOutlet weak var plantHealthNotesTextView: UITextView!
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        setupViews()
    }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let plantHealthNotes = plantHealthNotesTextView.text,
            let plantHealth = plantHealth,
            let imageData = imageData
            else {return}
        
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
    
    // MARK: - Segue to PhotoDetail
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhotoDetail" {
            let plantPhoto = self.plantPhoto
            let photoDetailVC = segue.destination as? PhotoDetailViewController
            photoDetailVC?.plantPhoto = plantPhoto
        }
        
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageData = UIImagePNGRepresentation(image)
            self.plantPhoto = image
            delegate?.photoSelectViewControllerSelected(image)
            thumbnailImageView.image = image
            
        }
    }
}
