//
//  PlantRecordViewController.swift
//  Sprout
//
//  Created by Kainoa Palama on 4/19/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//
//Make it so that the plant health only shows the one indicatior. it would be like "Plant Health: [5]" <-- that's supposed to be a button. ADD
//When view loads, scroll the textView(s) down and up once.

import UIKit

class PlantRecordViewController: UIViewController {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        setupViews()
    }
    
    // MARK: - Actions
    
    @IBOutlet weak var plantImage: UIImageView!
    @IBOutlet weak var ph: UILabel!
    @IBOutlet weak var conductivity: UILabel!
    @IBOutlet weak var volume: UILabel!
    @IBOutlet weak var water_FeedNotes: UITextView!
    
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    
    @IBOutlet weak var plantHealthNotes: UITextView!
    
    // MARK: - Views
    
    func setupViews() {
        //Make the date "pretty"
//        navigationItem.title = "\(day!.plantType!.type!): \(day!.date!)"
        
        plantImage.layer.cornerRadius = 6
        water_FeedNotes.layer.cornerRadius = 6
        plantHealthNotes.layer.cornerRadius = 6
        
        oneButton.layer.cornerRadius = 8
        twoButton.layer.cornerRadius = 8
        threeButton.layer.cornerRadius = 8
        fourButton.layer.cornerRadius = 8
        fiveButton.layer.cornerRadius = 8
        
        plantHealthNotes.layer.borderWidth = 1
        plantHealthNotes.layer.borderColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 0.4).cgColor
        water_FeedNotes.layer.borderWidth = 1
        water_FeedNotes.layer.borderColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 0.4).cgColor
    }
    
    func updateViews() {
        guard let plantImageData =  day?.plantRecord?.plantImage,
            let plantRecord = day?.plantRecord,
            let day = day
            else {return}
        let image = UIImage(data: plantImageData)
        
        let waterNotes = day.plantRecord?.water_feedNotes
        let healthNotes = day.plantRecord?.plantHealthNotes
        
        plantImage.image = image
        ph.text = "PH: \(plantRecord.phString)"
        conductivity.text = "PPM/EC: \(plantRecord.conductivityString)"
        volume.text = "Volume: \(plantRecord.volumeString)"
        water_FeedNotes.text = waterNotes ?? "You need to add some notes!"
        plantHealthNotes.text = healthNotes ?? "HI"
        
        setPlantHealthButtons(plantHealth: Int(plantRecord.plantHealth))
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
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhotoDetail" {
            guard let plantPhoto = plantImage.image else {return}
            let photoDetailVC = segue.destination as? PhotoDetailViewController
            photoDetailVC?.plantPhoto = plantPhoto
        }
    }
    
    // MARK: - Property
    
    var day: Day?
}
