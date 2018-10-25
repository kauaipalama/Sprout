//
//  PlantTypeDetailViewController.swift
//  Sprout
//
//  Created by Kainoa Palama on 4/19/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//

import UIKit

class PlantTypeDetailViewController: UIViewController {
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //bold the title
        navigationItem.title = "Main Menu"
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWater_feedVC" {
            let plantType = self.plantType
            let water_FeedVC = segue.destination as? Water_FeedViewController
            water_FeedVC?.plantType = plantType
        } else if segue.identifier == "toPlantHealthVC" {
            let plantType = self.plantType
            let plantHealthVC = segue.destination as? PlantHealthViewController
            plantHealthVC?.plantType = plantType
        } else if segue.identifier == "toCalendarVC" {
            let plantType = self.plantType
            let calendarVC = segue.destination as? CalendarViewController
            calendarVC?.plantType = plantType
        }
    }
    
    // MARK: - Property
    
    var plantType: PlantType?
    
}
