//
//  PlantRecordViewController.swift
//  Sprout
//
//  Created by Kainoa Palama on 4/19/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//

import UIKit

class PlantRecordViewController: UIViewController {
    
    var day: Day?
    
    @IBOutlet weak var plantImage: UIImageView!
    @IBOutlet weak var ph: UILabel!
    @IBOutlet weak var conductivity: UILabel!
    @IBOutlet weak var water_FeedNotes: UITextView!
    
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    
    @IBOutlet weak var plantHealthNotes: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        guard let plantImageData =  day?.plantRecord?.plantImage,
            let day = day     
            else {return}
        let image = UIImage(data: plantImageData)
        
        let watterNotes = day.plantRecord?.water_feedNotes
        let heathNotes = day.plantRecord?.plantHealthNotes
        
        plantImage.image = image
        ph.text = day.plantRecord?.ph.description
        conductivity.text = day.plantRecord?.conductivity.description
        water_FeedNotes.text = watterNotes ?? "You need to add some notes!"
        plantHealthNotes.text = heathNotes ?? "HI"
        
        guard let plantRecord = day.plantRecord else {return}
        setPlantHealthButtons(plantHealth: Int(plantRecord.plantHealth))
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
}
