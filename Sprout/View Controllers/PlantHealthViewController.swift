//
//  PlantHealthViewController.swift
//  Sprout
//
//  Created by Kainoa Palama on 4/19/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//
//TODO:
//For dark theme use a off white yellowish type of color for the textViews

import UIKit

protocol PlantHealthDetailControllerDelegate: class {
    func photoSelectViewControllerSelected(_ image: UIImage)
}

class PlantHealthViewController: ShiftableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        updateViews()
        plantHealthNotesTextView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return SproutTheme.current.preferredStatusBarStyle
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
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
        plantHealthNotesTextView.backgroundColor = SproutTheme.current.textFieldBackgroundColor
        plantHealthNotesTextView.layer.cornerRadius = 6
        
        plantHealthBar.layer.cornerRadius = 6
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
            plantImageButton.setBackgroundImage(plantPhoto, for: .normal)
            guard let plantRecord = day.plantRecord else {return}
            setPlantHealthButtons(plantHealth: Int(plantRecord.plantHealth))
            
        }
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
    
    func clearPlaceholderText() {
        if !plantHealthNotesTextView.text.isEmpty {
            plantHealthNotesTextView.placeholder = ""
        }
    }
    
    @objc func doneButtonTapped() {
        plantHealthNotesTextView.resignFirstResponder()
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
                print(self.view.frame.height)
                //*Just add specifics
                //5th 1024
                //6th
                //Air
                //Air 2
                //Pro 9.7
                //Pro 10.5
                //Pro 11
                //Pro 12.9
                //Pro 12.9.2
                //Pro 12.9.3
                
                if self.view.frame.height <= 763 {
                    //iPhone8 Plus
                    self.plantHealthBarTopConstraint.constant = keyboardSize.height / 2.525
                } else if self.view.frame.height <= 812 {
                    //iPhoneX
                    self.plantHealthBarTopConstraint.constant = keyboardSize.height / 2.0
                    self.plantImageButtonHeightConstraint.constant = 47
                } else if self.view.frame.height <= 896 {
                    //iPhoneXSMax
                    self.plantHealthBarTopConstraint.constant = keyboardSize.height / 1.95
                    self.plantImageButtonHeightConstraint.constant = 47
                } else if self.view.frame.height >= 1024.0 {
                    //iPad 5th
                    self.plantHealthBarTopConstraint.constant = keyboardSize.height / 3.45
                }
            }
        } else {
            UIView.animate(withDuration: keyboardAnimationDuration) {
                self.view.layoutIfNeeded()
                self.plantHealthBarTopConstraint.constant = 8
                self.plantImageButtonHeightConstraint.constant = 78
            }
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var plantHealthNotesTextView: PlaceholderTextView!
    @IBOutlet weak var plantHealthBar: UIView!
    @IBOutlet weak var poorHealthLabel: UILabel!
    @IBOutlet weak var excellantHealthLabel: UILabel!
    @IBOutlet weak var plantHealthBarTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var plantImageButton: UIButton!
    @IBOutlet weak var plantImageButtonHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if plantHealth == nil {
            print("Present alert controller")
            let alert = UIAlertController(title: "Before you go:", message: "-Rate Plant Health between 1-5\n\nOptional:\n-Take a photo\n-Take Notes", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
        if imageData == nil {
            //Do something
            let defaultImage = UIImage(named: "LaunchScreen")
            guard let defaultImageData = defaultImage?.jpegData(compressionQuality: 0) else {return}
            imageData = defaultImageData
        }
        
        if plantHealthNotesTextView.text.isEmpty {
            
        }
        
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
            plantImageButton.setBackgroundImage(image, for: .normal)
            
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
