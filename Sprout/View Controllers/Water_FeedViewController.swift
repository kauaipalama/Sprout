//
//  Water_FeedViewController.swift
//  Sprout
//
//  Created by Kainoa Palama on 4/19/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//

import UIKit

class Water_FeedViewController: UIViewController {
    
    // MARK: - Properties
    var plantType: PlantType?
    
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
        
        if let plantRecord = plantType?.plantRecords?.filter({ ($0 as! PlantRecord).date == Date() }).first as? PlantRecord {
        PlantRecordController.shared.updatePlantRecordWater_Feed(ph: ph, conductivity: conductivity, volume: volume, water_feedNotes: water_feedNotes, plantRecord: plantRecord)
        } else {
            let plantRecord = PlantRecordController.shared.createBlankPlantRecord()
            PlantRecordController.shared.updatePlantRecordWater_Feed(ph: ph, conductivity: conductivity, volume: volume, water_feedNotes: water_feedNotes, plantRecord: plantRecord)
    }
        navigationController?.popViewController(animated: true)
}

// MARK: - Outlets
@IBOutlet weak var conductivityTextField: UITextField!
@IBOutlet weak var phTextField: UITextField!
@IBOutlet weak var volumeTextField: UITextField!
@IBOutlet weak var water_FeedNotesTextView: UITextView!


override func viewDidLoad() {
    super.viewDidLoad()
}
}
