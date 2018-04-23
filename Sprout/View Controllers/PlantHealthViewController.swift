//
//  PlantHealthViewController.swift
//  Sprout
//
//  Created by Kainoa Palama on 4/19/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//

import UIKit

protocol PlantHealthDetailControllerDelegate: class {
    func photoSelectViewControllerSelected(_ image: UIImage)
}

class PlantHealthViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //TODO:
    //When plantHealth buttont tapped - Highlight selected button and grey out background of other buttons. Also set plantHealth value.
    //When camera button is tapped segue to in app camera
    //When no picture exists have placeholder for thumbnail
    //Implement save function
    
    // MARK: - Properties
    weak var delegate: PlantHealthDetailControllerDelegate?
    var plantType: PlantType?
    var plantHealth: Int16? = 0
    var imageData: Data?
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let plantHealthNotes = plantHealthNotesTextView.text,
            let plantHealth = plantHealth,
            let imageData = imageData
            else {return}
        
        if let plantRecord = plantType?.plantRecords?.filter({ ($0 as! PlantRecord).date == Date() }).first as? PlantRecord {
            PlantRecordController.shared.updatePlantRecordHealth(plantHealth: plantHealth, plantHealthNotes: plantHealthNotes, plantImage: imageData, plantRecord: plantRecord)
        } else {
            let plantRecord = PlantRecordController.shared.createBlankPlantRecord()
            PlantRecordController.shared.updatePlantRecordHealth(plantHealth: plantHealth, plantHealthNotes: plantHealthNotes, plantImage: imageData, plantRecord: plantRecord)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func oneButtonTapped(_ sender: Any) {
        print("one button tapped")
        plantHealth = 1
        oneButton.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        twoButton.backgroundColor = UIColor.lightGray
        threeButton.backgroundColor = UIColor.lightGray
        fourButton.backgroundColor = UIColor.lightGray
        fiveButton.backgroundColor = UIColor.lightGray
        
    }
    
    @IBAction func twoButtonTapped(_ sender: Any) {
        print("two button tapped")
        plantHealth = 2
        oneButton.backgroundColor = UIColor.lightGray
        twoButton.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        threeButton.backgroundColor = UIColor.lightGray
        fourButton.backgroundColor = UIColor.lightGray
        fiveButton.backgroundColor = UIColor.lightGray
    }
    
    @IBAction func threeButtonTapped(_ sender: Any) {
        print("three button tapped")
        plantHealth = 3
        oneButton.backgroundColor = UIColor.lightGray
        twoButton.backgroundColor = UIColor.lightGray
        threeButton.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        fourButton.backgroundColor = UIColor.lightGray
        fiveButton.backgroundColor = UIColor.lightGray
    }
    
    @IBAction func fourButtonTapped(_ sender: Any) {
        print("four button tapped")
        plantHealth = 4
        oneButton.backgroundColor = UIColor.lightGray
        twoButton.backgroundColor = UIColor.lightGray
        threeButton.backgroundColor = UIColor.lightGray
        fourButton.backgroundColor = #colorLiteral(red: 0.8493849635, green: 1, blue: 0, alpha: 1)
        fiveButton.backgroundColor = UIColor.lightGray
    }
    
    @IBAction func fiveButtonTapped(_ sender: Any) {
        print("five button tapped")
        plantHealth = 5
        oneButton.backgroundColor = UIColor.lightGray
        twoButton.backgroundColor = UIColor.lightGray
        threeButton.backgroundColor = UIColor.lightGray
        fourButton.backgroundColor = UIColor.lightGray
        fiveButton.backgroundColor = #colorLiteral(red: 0, green: 0.9275812507, blue: 0.03033527173, alpha: 1)
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
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageData = UIImagePNGRepresentation(image)
            delegate?.photoSelectViewControllerSelected(image)
            thumbnailImageView.image = image
            
        }
    }
    
}
