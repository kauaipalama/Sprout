//
//  PlantRecordViewController.swift
//  Sprout
//
//  Created by Kainoa Palama on 4/19/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//
//When view loads, scroll the textView(s) down and up once.

//Add ability for views to change with theme
//Needs redesign
//For dark theme use a off white yellowish type of color for the textViews

//Need to switch theme colors for plant health buttons. Make darker buttons correspond with light mode and vice versa
//Change text of buttons with theme switching

import UIKit

class PlantRecordViewController: UIViewController {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        setupViews()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return SproutTheme.current.preferredStatusBarStyle
    }
    
    // MARK: - Views
    
    func setupViews() {
        //Make the date "pretty"
//        navigationItem.title = "\(day!.plantType!.type!): \(day!.date!)"
        view.backgroundColor = SproutTheme.current.backgroundColor
        volume.textColor = SproutTheme.current.textColor
        conductivity.textColor = SproutTheme.current.textColor
        ph.textColor = SproutTheme.current.textColor
        plantHealth.textColor = SproutTheme.current.textColor
        plantHealthBackslash.textColor = SproutTheme.current.textColor

        
        plantImage.layer.cornerRadius = 6
        water_FeedNotes.layer.cornerRadius = 6
        plantHealthNotes.layer.cornerRadius = 6
        
        plantHealthFirstButton.layer.cornerRadius = 4
        plantHealthSecondButton.layer.cornerRadius = 4
        plantHealthSecondButton.backgroundColor = SproutTheme.current.health5Color
        
        plantHealthNotes.layer.borderWidth = 1
        plantHealthNotes.layer.borderColor = SproutTheme.current.accentColor.cgColor
        water_FeedNotes.layer.borderWidth = 1
        water_FeedNotes.layer.borderColor = SproutTheme.current.accentColor.cgColor
    }
    
    func updateViews() {
        guard let plantRecord = day?.plantRecord,
            let day = day
            else {return}
        
        let plantImageData = day.plantRecord?.plantImage

        let defaultImage = UIImage(named: "LaunchScreen")
        guard let defaultImageData = defaultImage?.jpegData(compressionQuality: 0) else {return}
        
        let image = UIImage(data: plantImageData ?? defaultImageData)
        
        let waterNotes = day.plantRecord?.water_feedNotes
        let healthNotes = day.plantRecord?.plantHealthNotes
        
        var volumeStringIsNA: Bool
        
        if plantRecord.volumeString == "N/A" {
            volumeStringIsNA = true
        } else {
            volumeStringIsNA = false
        }
        
        plantImage.image = image
        ph.text = plantRecord.phString
        conductivity.text = plantRecord.conductivityString
        volume.text = volumeStringIsNA ? "Volume: \(plantRecord.volumeString)" : plantRecord.volumeString
        water_FeedNotes.text = waterNotes ?? "N/A"
        plantHealthNotes.text = healthNotes ?? "N/A"
        
        setPlantHealthButtons(plantHealth: Int(plantRecord.plantHealth))
    }
    
    func setPlantHealthButtons(plantHealth: Int) {
        switch plantHealth {
        case 1:
            plantHealthFirstButton.backgroundColor = SproutTheme.current.health1Color
            plantHealthFirstButton.text = "\(plantHealth)"
            
        case 2:
            plantHealthFirstButton.backgroundColor = SproutTheme.current.health2Color
            plantHealthFirstButton.text = "\(plantHealth)"
            
        case 3:
            plantHealthFirstButton.backgroundColor = SproutTheme.current.health3Color
            plantHealthFirstButton.text = "\(plantHealth)"

        case 4:
            plantHealthFirstButton.backgroundColor = SproutTheme.current.health4Color
            plantHealthFirstButton.text = "\(plantHealth)"
            
        case 5:
            plantHealthFirstButton.backgroundColor = SproutTheme.current.health5Color
            plantHealthFirstButton.text = "\(plantHealth)"
            
        default:
            plantHealthFirstButton.backgroundColor = SproutTheme.current.health1Color
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
    
    // MARK: - Outlets
    
    @IBOutlet weak var plantImage: UIImageView!
    @IBOutlet weak var ph: UILabel!
    
    //Change naming conventions. So it does not match data model.
    @IBOutlet weak var conductivity: UILabel!
    @IBOutlet weak var volume: UILabel!
    @IBOutlet weak var water_FeedNotes: UITextView!
    @IBOutlet weak var plantHealthFirstButton: UILabel!
    @IBOutlet weak var plantHealthSecondButton: UILabel!
    @IBOutlet weak var plantHealthNotes: UITextView!
    @IBOutlet weak var plantHealth: UILabel!
    @IBOutlet weak var plantHealthBackslash: UILabel!
    
    // MARK: - Property
    
    var day: Day?
}
